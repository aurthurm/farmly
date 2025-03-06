import 'package:flora_orm/flora_orm.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../entities/farmdata/farmdata.entity.dart';


class FarmerRepository extends ChangeNotifier {
  final orm = GetIt.I<OrmManager>();

  Future<FarmDataEntity?> addFarmData(FarmDataEntity farmData) async {
    final FarmDataEntityOrm storage = orm.getStorage(const FarmDataEntity());
    final entity = await storage.insert(farmData);
    notifyListeners();
    return entity;
  }

  Future<List<FarmDataEntity>> getAllFarmData() async {
    final FarmDataEntityOrm storage = orm.getStorage(const FarmDataEntity());
    return await storage.where();
  }
}
