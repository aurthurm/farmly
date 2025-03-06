import 'package:flora_orm/flora_orm.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../entities/user/user.entity.dart';

class UserRepository extends ChangeNotifier {
  final orm = GetIt.I<OrmManager>();

  Future<UserEntity?> addUser(UserEntity user) async {
    final UserEntityOrm storage = orm.getStorage(const UserEntity());
    final entity = await storage.insert(user);
    notifyListeners();
    return entity;
  }

  Future<List<UserEntity>> getAllUsers() async {
    final UserEntityOrm storage = orm.getStorage(const UserEntity());
    return await storage.where();
  }
}
