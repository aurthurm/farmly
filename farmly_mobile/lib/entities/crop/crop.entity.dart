import 'package:flora_orm/flora_orm.dart';

part 'crop.entity.g.dart';
part 'crop.entity.migrations.dart';

@OrmEntity(tableName: 'crop')
class CropEntity extends Entity<CropEntity, CropEntityMeta>
    with _CropEntityMixin, CropEntityMigrations {

  const CropEntity({
    super.id,
    super.collectionId,
    super.createdAt,
    super.updatedAt,
    this.name,
  });

  factory CropEntity.fromMap(map) {
    return const CropEntity().load(map);
  }

  @override
  @column
  final String? name;
}