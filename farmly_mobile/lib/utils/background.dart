import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';
import '../entities/crop/crop.entity.dart';
import '../constants/constants.dart';
import 'package:flora_orm/flora_orm.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../entities/farmdata/farmdata.entity.dart';
import '../entities/farmtype/farmtype.entity.dart';
import '../orm.init.dart';

const fetchBackground = "FarmlySync";

@pragma('vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    initOrm();
    switch (task) {
      case fetchBackground:
        await AppSync().synchronise(bgSync: true);
        break;
    }
    return Future.value(true);
  });
}

class FarmlySynchronizer {
  Future<void> initialise() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );
    // Scheduler
    await Workmanager().registerOneOffTask(
      "eport_farmly",
      fetchBackground,
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );
    //
    await Workmanager().registerPeriodicTask(
      "eport_farmly",
      fetchBackground,
      frequency: const Duration(minutes: PERIODIC_SYNC_MINUTES),
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );
  }
}

class AppSync {
  final orm = GetIt.I<OrmManager>();

  Future post(String url, dynamic data) async {
    print("Posting to :: ${url}");
    try {
      print("data :::: ${data}");
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json'
        },
        body: jsonEncode(data),
      );

      if ([200,201,202].contains(response.statusCode)) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      return [];
    }
  }

  Future get(String url) async {
    print("Getting from :: ${url}");
    try {
      final response = await http.get(Uri.parse(url));
      if ([200,201,202].contains(response.statusCode)) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      return [];
    }
  }

  Future<void> syncUp() async {
    // sync crops
    final CropEntityOrm cropStorage = orm.getStorage(const CropEntity());
    final crops = await cropStorage.where();
    if(crops.isNotEmpty){
      final cropChunks = _getChunks(crops.map((crop) => crop.toMap()).toList(), 100);
      for (var chunk in cropChunks) {
        var response = await post('$BACKEND_URL/farms/crops/sync', chunk);
        if(response != null){
          for(var crop in response){
            await cropStorage.update(
              where: (t) => Filter(
                t.id,
                condition: OrmCondition.equalTo,
                value: 20,
              ),
              entity: CropEntity.fromMap(crop),
            );
          }
        }
      }
    }

    // sync farm types
    final FarmTypeEntityOrm farmTypeStorage = orm.getStorage(const FarmTypeEntity());
    final farmTypes = await farmTypeStorage.where();
    if(farmTypes.isNotEmpty){
      final cropChunks = _getChunks(farmTypes.map((ft) => ft.toMap()).toList(), 100);
      for (var chunk in cropChunks) {
        var response = await post('$BACKEND_URL/farms/farm-types/sync', chunk);
        if(response != null){
          for(var ft in response){
            await farmTypeStorage.update(
              where: (t) => Filter(
                t.id,
                condition: OrmCondition.equalTo,
                value: 20,
              ),
              entity: FarmTypeEntity.fromMap(ft),
            );
          }
        }
      }
    }

    // sync farm data
    final FarmDataEntityOrm farmDataStorage = orm.getStorage(const FarmDataEntity());
    final farmDatas = await farmDataStorage.where();
    if(farmDatas.isNotEmpty){
      final cropChunks = _getChunks(farmDatas.map((fd) => fd.toMap()).toList(), 100);
      for (var chunk in cropChunks) {
        var cresponse = await post('$BACKEND_URL/farms/farmer-data/sync', chunk);
        if(cresponse != null){
          for(var fd in cresponse){
            await farmDataStorage.update(
              where: (t) => Filter(
                t.id,
                condition: OrmCondition.equalTo,
                value: 20,
              ),
              entity: FarmDataEntity.fromMap(fd),
            );
          }
        }
      }
    }
  }

  Future<void> syncDown() async {
    // download crops
    final CropEntityOrm cropStorage = orm.getStorage(const CropEntity());
    var response = await get('$BACKEND_URL/farms/crops/sync');
    if(response != null){
      for(var crop in response){
        await cropStorage.insertOrUpdate(CropEntity.fromMap(crop));
      }
    }

    // download farm types
    final FarmTypeEntityOrm farmTypeStorage = orm.getStorage(const FarmTypeEntity());
    var ftResponse = await get('$BACKEND_URL/farms/farm-types/sync');
    if(ftResponse != null){
      for(var ft in ftResponse){
        await farmTypeStorage.insertOrUpdate(FarmTypeEntity.fromMap(ft));
      }
    }

    // download farm data
    final FarmDataEntityOrm farmDataStorage = orm.getStorage(const FarmDataEntity());
    var fdResponse = await get('$BACKEND_URL/farms/farmer-data/sync');
    if(fdResponse != null){
      for(var fd in fdResponse){
        await farmDataStorage.insertOrUpdate(FarmDataEntity.fromMap(fd));
      }
    }
  }

  Future<void> synchronise({bool bgSync = false}) async {
    await syncUp();
    await syncDown();
  }
}


List _getChunks(List data, int size) {
  var len = data.length;
  var chunks = [];

  for(var i = 0; i< len; i+= size)
  {
    var end = (i+size<len)?i+size:len;
    chunks.add(data.sublist(i,end));
  }
  return chunks;
}