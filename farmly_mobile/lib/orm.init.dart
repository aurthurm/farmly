import 'package:farmly_mobile/entities/crop/crop.entity.dart';
import 'package:farmly_mobile/entities/farmdata/farmdata.entity.dart';
import 'package:farmly_mobile/entities/farmtype/farmtype.entity.dart';
import 'package:flora_orm/flora_orm.dart';
import 'package:get_it/get_it.dart';
import 'entities/user/user.entity.dart';

void initOrm() {
    final ormManager = OrmManager(
        /// update this version number whenever you add or update your entities
        /// such as adding new properties/fields.
        dbVersion: 1,
        engine: DbEngine.sqflite,
        dbName: 'eportfarm.db',
        tables: const <Entity>[
            UserEntity(),
            CropEntity(),
            FarmTypeEntity(),
            FarmDataEntity()
        ],
    );
    GetIt.I.registerSingleton(ormManager);
}