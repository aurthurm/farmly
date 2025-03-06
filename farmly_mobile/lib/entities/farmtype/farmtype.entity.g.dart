// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'farmtype.entity.dart';

// **************************************************************************
// EntityPropsGenerator
// **************************************************************************

mixin _FarmTypeEntityMixin on Entity<FarmTypeEntity, FarmTypeEntityMeta> {
  static const FarmTypeEntityMeta _meta = FarmTypeEntityMeta();

  @override
  FarmTypeEntityMeta get meta => _meta;

  String? get name;

  @override
  List<Object?> get props => [...super.props, name];
  @override
  FarmTypeEntity copyWith({
    String? id,
    String? collectionId,
    DateTime? createdAt,
    DateTime? updatedAt,
    CopyWith<String?>? name,

    Map<String, dynamic>? json,
  }) {
    return FarmTypeEntity(
      id: id ?? this.id,
      collectionId: collectionId ?? this.collectionId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name != null ? name.value : this.name,
    );
  }
}
typedef FarmTypeEntityOrm =
    OrmEngine<FarmTypeEntity, FarmTypeEntityMeta, DbContext<FarmTypeEntity>>;

class FarmTypeEntityMeta extends EntityMeta<FarmTypeEntity> {
  const FarmTypeEntityMeta();

  @override
  String get tableName => 'farmtype';

  @override
  ColumnDefinition<FarmTypeEntity, String> get id =>
      ColumnDefinition<FarmTypeEntity, String>(
        'id',
        primaryKey: true,
        write: (entity) => entity.id,
        read: (json, entity, value) => entity.copyWith(id: value, json: json),
      );

  @override
  ColumnDefinition<FarmTypeEntity, String> get collectionId =>
      ColumnDefinition<FarmTypeEntity, String>(
        'collectionId',
        write: (entity) => entity.collectionId,
        read:
            (json, entity, value) =>
                entity.copyWith(collectionId: value, json: json),
      );

  @override
  ColumnDefinition<FarmTypeEntity, DateTime> get createdAt =>
      ColumnDefinition<FarmTypeEntity, DateTime>(
        'createdAt',
        write: (entity) => entity.createdAt,
        read:
            (json, entity, value) =>
                entity.copyWith(createdAt: value, json: json),
      );

  @override
  ColumnDefinition<FarmTypeEntity, DateTime> get updatedAt =>
      ColumnDefinition<FarmTypeEntity, DateTime>(
        'updatedAt',
        write: (entity) => entity.updatedAt,
        read:
            (json, entity, value) =>
                entity.copyWith(updatedAt: value, json: json),
      );

  ColumnDefinition<FarmTypeEntity, String> get name =>
      ColumnDefinition<FarmTypeEntity, String>(
        'name',

        write: (entity) => entity.name,

        read:
            (json, entity, value) =>
                entity.copyWith(name: CopyWith(value), json: json),
      );

  @override
  Iterable<ColumnDefinition<FarmTypeEntity, dynamic>> get columns => [
    id,
    collectionId,
    createdAt,
    updatedAt,

    name,
  ];
}
