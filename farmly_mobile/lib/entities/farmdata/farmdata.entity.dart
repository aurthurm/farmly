import 'package:flora_orm/flora_orm.dart';

part 'farmdata.entity.g.dart';
part 'farmdata.entity.migrations.dart';

@OrmEntity(tableName: 'farmdata')
class FarmDataEntity extends Entity<FarmDataEntity, FarmDataEntityMeta>
    with _FarmDataEntityMixin, FarmDataEntityMigrations {

  const FarmDataEntity({
    super.id,
    super.collectionId,
    super.createdAt,
    super.updatedAt,
    this.farmerName,
    this.nationalId,
    this.farmTypeId,
    this.cropId,
    this.location,
  });

  factory FarmDataEntity.fromMap(map) {
    return const FarmDataEntity().load(map);
  }

  @override
  @column
  final String? farmerName;

  @override
  @column
  final String? nationalId;

  @override
  @column
  final String? farmTypeId;

  @override
  @column
  final String? cropId;

  @override
  @column
  final String? location;
}