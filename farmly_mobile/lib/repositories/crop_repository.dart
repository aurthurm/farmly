import 'package:flora_orm/flora_orm.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../entities/crop/crop.entity.dart';

class CropRepository extends ChangeNotifier {
  final orm = GetIt.I<OrmManager>();

  Future<CropEntity?> addCrop(CropEntity crop) async {
    final CropEntityOrm storage = orm.getStorage(const CropEntity());
    final entity = await storage.insert(crop);
    notifyListeners();
    return entity;
  }

  Future<List<CropEntity>> getAllCrops() async {
    final CropEntityOrm storage = orm.getStorage(const CropEntity());
    return await storage.where();
  }
}
