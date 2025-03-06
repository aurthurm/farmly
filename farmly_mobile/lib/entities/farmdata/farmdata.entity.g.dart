// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'farmdata.entity.dart';

// **************************************************************************
// EntityPropsGenerator
// **************************************************************************

mixin _FarmDataEntityMixin on Entity<FarmDataEntity, FarmDataEntityMeta> {
  static const FarmDataEntityMeta _meta = FarmDataEntityMeta();

  @override
  FarmDataEntityMeta get meta => _meta;

  String? get farmerName;
  String? get nationalId;
  String? get farmTypeId;
  String? get cropId;
  String? get location;

  @override
  List<Object?> get props => [
    ...super.props,

    farmerName,
    nationalId,
    farmTypeId,
    cropId,
    location,
  ];
  @override
  FarmDataEntity copyWith({
    String? id,
    String? collectionId,
    DateTime? createdAt,
    DateTime? updatedAt,
    CopyWith<String?>? farmerName,
    CopyWith<String?>? nationalId,
    CopyWith<String?>? farmTypeId,
    CopyWith<String?>? cropId,
    CopyWith<String?>? location,

    Map<String, dynamic>? json,
  }) {
    return FarmDataEntity(
      id: id ?? this.id,
      collectionId: collectionId ?? this.collectionId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      farmerName: farmerName != null ? farmerName.value : this.farmerName,
      nationalId: nationalId != null ? nationalId.value : this.nationalId,
      farmTypeId: farmTypeId != null ? farmTypeId.value : this.farmTypeId,
      cropId: cropId != null ? cropId.value : this.cropId,
      location: location != null ? location.value : this.location,
    );
  }
}
typedef FarmDataEntityOrm =
    OrmEngine<FarmDataEntity, FarmDataEntityMeta, DbContext<FarmDataEntity>>;

class FarmDataEntityMeta extends EntityMeta<FarmDataEntity> {
  const FarmDataEntityMeta();

  @override
  String get tableName => 'farmdata';

  @override
  ColumnDefinition<FarmDataEntity, String> get id =>
      ColumnDefinition<FarmDataEntity, String>(
        'id',
        primaryKey: true,
        write: (entity) => entity.id,
        read: (json, entity, value) => entity.copyWith(id: value, json: json),
      );

  @override
  ColumnDefinition<FarmDataEntity, String> get collectionId =>
      ColumnDefinition<FarmDataEntity, String>(
        'collectionId',
        write: (entity) => entity.collectionId,
        read:
            (json, entity, value) =>
                entity.copyWith(collectionId: value, json: json),
      );

  @override
  ColumnDefinition<FarmDataEntity, DateTime> get createdAt =>
      ColumnDefinition<FarmDataEntity, DateTime>(
        'createdAt',
        write: (entity) => entity.createdAt,
        read:
            (json, entity, value) =>
                entity.copyWith(createdAt: value, json: json),
      );

  @override
  ColumnDefinition<FarmDataEntity, DateTime> get updatedAt =>
      ColumnDefinition<FarmDataEntity, DateTime>(
        'updatedAt',
        write: (entity) => entity.updatedAt,
        read:
            (json, entity, value) =>
                entity.copyWith(updatedAt: value, json: json),
      );

  ColumnDefinition<FarmDataEntity, String> get farmerName =>
      ColumnDefinition<FarmDataEntity, String>(
        'farmerName',

        write: (entity) => entity.farmerName,

        read:
            (json, entity, value) =>
                entity.copyWith(farmerName: CopyWith(value), json: json),
      );

  ColumnDefinition<FarmDataEntity, String> get nationalId =>
      ColumnDefinition<FarmDataEntity, String>(
        'nationalId',

        write: (entity) => entity.nationalId,

        read:
            (json, entity, value) =>
                entity.copyWith(nationalId: CopyWith(value), json: json),
      );

  ColumnDefinition<FarmDataEntity, String> get farmTypeId =>
      ColumnDefinition<FarmDataEntity, String>(
        'farmTypeId',

        write: (entity) => entity.farmTypeId,

        read:
            (json, entity, value) =>
                entity.copyWith(farmTypeId: CopyWith(value), json: json),
      );

  ColumnDefinition<FarmDataEntity, String> get cropId =>
      ColumnDefinition<FarmDataEntity, String>(
        'cropId',

        write: (entity) => entity.cropId,

        read:
            (json, entity, value) =>
                entity.copyWith(cropId: CopyWith(value), json: json),
      );

  ColumnDefinition<FarmDataEntity, String> get location =>
      ColumnDefinition<FarmDataEntity, String>(
        'location',

        write: (entity) => entity.location,

        read:
            (json, entity, value) =>
                entity.copyWith(location: CopyWith(value), json: json),
      );

  @override
  Iterable<ColumnDefinition<FarmDataEntity, dynamic>> get columns => [
    id,
    collectionId,
    createdAt,
    updatedAt,

    farmerName,
    nationalId,
    farmTypeId,
    cropId,
    location,
  ];
}
