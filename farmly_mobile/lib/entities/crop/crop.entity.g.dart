// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crop.entity.dart';

// **************************************************************************
// EntityPropsGenerator
// **************************************************************************

mixin _CropEntityMixin on Entity<CropEntity, CropEntityMeta> {
  static const CropEntityMeta _meta = CropEntityMeta();

  @override
  CropEntityMeta get meta => _meta;

  String? get name;

  @override
  List<Object?> get props => [...super.props, name];
  @override
  CropEntity copyWith({
    String? id,
    String? collectionId,
    DateTime? createdAt,
    DateTime? updatedAt,
    CopyWith<String?>? name,

    Map<String, dynamic>? json,
  }) {
    return CropEntity(
      id: id ?? this.id,
      collectionId: collectionId ?? this.collectionId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name != null ? name.value : this.name,
    );
  }
}
typedef CropEntityOrm =
    OrmEngine<CropEntity, CropEntityMeta, DbContext<CropEntity>>;

class CropEntityMeta extends EntityMeta<CropEntity> {
  const CropEntityMeta();

  @override
  String get tableName => 'crop';

  @override
  ColumnDefinition<CropEntity, String> get id =>
      ColumnDefinition<CropEntity, String>(
        'id',
        primaryKey: true,
        write: (entity) => entity.id,
        read: (json, entity, value) => entity.copyWith(id: value, json: json),
      );

  @override
  ColumnDefinition<CropEntity, String> get collectionId =>
      ColumnDefinition<CropEntity, String>(
        'collectionId',
        write: (entity) => entity.collectionId,
        read:
            (json, entity, value) =>
                entity.copyWith(collectionId: value, json: json),
      );

  @override
  ColumnDefinition<CropEntity, DateTime> get createdAt =>
      ColumnDefinition<CropEntity, DateTime>(
        'createdAt',
        write: (entity) => entity.createdAt,
        read:
            (json, entity, value) =>
                entity.copyWith(createdAt: value, json: json),
      );

  @override
  ColumnDefinition<CropEntity, DateTime> get updatedAt =>
      ColumnDefinition<CropEntity, DateTime>(
        'updatedAt',
        write: (entity) => entity.updatedAt,
        read:
            (json, entity, value) =>
                entity.copyWith(updatedAt: value, json: json),
      );

  ColumnDefinition<CropEntity, String> get name =>
      ColumnDefinition<CropEntity, String>(
        'name',

        write: (entity) => entity.name,

        read:
            (json, entity, value) =>
                entity.copyWith(name: CopyWith(value), json: json),
      );

  @override
  Iterable<ColumnDefinition<CropEntity, dynamic>> get columns => [
    id,
    collectionId,
    createdAt,
    updatedAt,

    name,
  ];
}
