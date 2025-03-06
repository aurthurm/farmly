import 'package:flutter/material.dart';

class DataSyncService extends ChangeNotifier {
  bool _isSyncing = false;

  bool get isSyncing => _isSyncing;

  Future<void> syncData() async {
    _isSyncing = true;
    notifyListeners();
    // TODO: Implement real data synchronization with the FastAPI backend.
    await Future.delayed(Duration(seconds: 2));
    _isSyncing = false;
    notifyListeners();
  }
}
