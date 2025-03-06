import 'dart:convert';
import 'package:farmly_mobile/entities/user/user.entity.dart';
import 'package:farmly_mobile/utils/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:bcrypt/bcrypt.dart';

import '../constants/constants.dart';
import '../constants/user_role.dart';

class AuthService extends ChangeNotifier {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  bool _isAuthenticated = false;
  bool _isAdmin = false;
  UserEntity? _currentUser;
  bool _isOnline = true; // Track connectivity state

  bool get isAuthenticated => _isAuthenticated;
  bool get  isAdmin => _isAdmin;
  UserEntity get currentUser => _currentUser!;

  // Check connectivity
  Future<bool> _checkConnectivity() async {
    _isOnline = await getConnectivityStatus();
    return _isOnline;
  }

  // Main login function
  Future<bool> login(String username, String password) async {
    await _checkConnectivity();

    print("_isOnline :::::::::::::::::::::::::: ${_isOnline}");

    if (_isOnline) {
      return await _onlineLogin(username, password);
    } else {
      return await _offlineLogin(username, password);
    }
  }

  // Online login
  Future<bool> _onlineLogin(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$BACKEND_URL/users/login/access-token'),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: {
          'username': username,
          'password': password,
        },
      );

      print("response.statusCode :::::::::::::::::::::::::: ${response.statusCode}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Store token and user details
        await _storage.write(key: 'auth_token', value: data['access_token']);
        await _storage.write(key: 'username', value: username);

        // Store hashed password for offline login
        if (data["user"].containsKey('password')) {
          await _storage.write(key: 'password', value: data["user"]['password']);
        }

        // Determine role from response or default
        UserRole role = data["user"]["role"].toLowerCase().contains('admin')
            ? UserRole.ADMIN
            : UserRole.CLERK;

        if (data.containsKey('role')) {
          role = data['role'] == 'ADMIN' ? UserRole.ADMIN : UserRole.CLERK;
        }

        // Create user entity
        _currentUser = UserEntity(
          username: username,
          firstname: data['firstname'] ?? 'First',
          lastname: data['lastname'] ?? 'Last',
          password: '', // Don't store raw password in memory
          role: role,
        );

        _isAuthenticated = true;
        _isAdmin = role == UserRole.ADMIN;
        notifyListeners();
        return true;
      }
      print("Online login failed :::::::::::::::::::::::::: ${response.body}");
      return false;
    } catch (e) {
      // If online login fails, try offline
      return await _offlineLogin(username, password);
    }
  }

  // Offline login
  Future<bool> _offlineLogin(String username, String password) async {
    final storedUsername = await _storage.read(key: 'username');
    final storedHash = await _storage.read(key: 'password');

    // First time login must be online
    if (storedUsername == null || storedHash == null) {
      return false;
    }

    // Username must match
    if (storedUsername != username) {
      return false;
    }

    // Verify password using bcrypt
    final isPasswordValid = BCrypt.checkpw(password, storedHash);

    if (isPasswordValid) {
      // Restore user from storage
      final userData = await _storage.read(key: 'user_data');
      if (userData != null) {
        final userMap = jsonDecode(userData);
        _currentUser = UserEntity(
          username: username,
          firstname: userMap['firstname'] ?? 'First',
          lastname: userMap['lastname'] ?? 'Last',
          password: '', // Don't store raw password
          role: userMap['role'] == 'ADMIN' ? UserRole.ADMIN : UserRole.CLERK,
        );
      } else {
        // Fallback if no stored user data
        UserRole role = username.toLowerCase().contains('admin')
            ? UserRole.ADMIN
            : UserRole.CLERK;
        _currentUser = UserEntity(
          username: username,
          firstname: 'First',
          lastname: 'Last',
          password: '',
          role: role,
        );
      }

      _isAuthenticated = true;
      _isAdmin = _currentUser?.role == UserRole.ADMIN;
      notifyListeners();
      return true;
    }

    return false;
  }

  // Logout
  Future<void> logout() async {
    _isAuthenticated = false;
    _isAdmin = false;
    _currentUser = null;
    // Keep credentials for offline login, but invalidate session
    await _storage.delete(key: 'auth_token');
    notifyListeners();
  }

  // Clear all auth data (use when completely signing out)
  Future<void> clearAuthData() async {
    await _storage.delete(key: 'auth_token');
    await _storage.delete(key: 'username');
    await _storage.delete(key: 'password');
    await _storage.delete(key: 'user_data');
    _isAuthenticated = false;
    _isAdmin = false;
    _currentUser = null;
    notifyListeners();
  }

  // Store user data for offline use
  Future<void> _storeUserData() async {
    if (_currentUser != null) {
      final userData = {
        'username': _currentUser!.username,
        'firstname': _currentUser!.firstname,
        'lastname': _currentUser!.lastname,
        'role': _currentUser!.role == UserRole.ADMIN ? 'ADMIN' : 'CLERK',
      };
      await _storage.write(key: 'user_data', value: jsonEncode(userData));
    }
  }
}