import 'package:flora_orm/flora_orm.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../entities/farmtype/farmtype.entity.dart';

class FarmTypeRepository extends ChangeNotifier {
  final orm = GetIt.I<OrmManager>();

  Future<FarmTypeEntity?> addFarmtype(FarmTypeEntity farmType) async {
    final FarmTypeEntityOrm storage = orm.getStorage(const FarmTypeEntity());
    final entity = await storage.insert(farmType);
    notifyListeners();
    return entity;
  }

  Future<List<FarmTypeEntity>> getAllFarmtypes() async {
    final FarmTypeEntityOrm storage = orm.getStorage(const FarmTypeEntity());
    return await storage.where();
  }
}
