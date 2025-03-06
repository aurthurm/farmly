import 'package:flora_orm/flora_orm.dart';

part 'farmtype.entity.g.dart';
part 'farmtype.entity.migrations.dart';

@OrmEntity(tableName: 'farmtype')
class FarmTypeEntity extends Entity<FarmTypeEntity, FarmTypeEntityMeta>
    with _FarmTypeEntityMixin, FarmTypeEntityMigrations {

  const FarmTypeEntity({
    super.id,
    super.collectionId,
    super.createdAt,
    super.updatedAt,
    this.name,
  });

  factory FarmTypeEntity.fromMap(map) {
    return const FarmTypeEntity().load(map);
  }

  @override
  @column
  final String? name;
}