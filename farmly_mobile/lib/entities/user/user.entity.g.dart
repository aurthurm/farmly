// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.entity.dart';

// **************************************************************************
// EntityPropsGenerator
// **************************************************************************

mixin _UserEntityMixin on Entity<UserEntity, UserEntityMeta> {
  static const UserEntityMeta _meta = UserEntityMeta();

  @override
  UserEntityMeta get meta => _meta;

  UserEntity readRole(Map<String, dynamic> json, value) {
    UserRole? item;
    if (value != null) {
      item = <UserRole?>[...UserRole.values].firstWhere(
        (element) => element?.name == value as String,
        orElse: () => null,
      );
    }
    return copyWith(role: CopyWith(item));
  }

  String? get firstname;
  String? get lastname;
  String? get username;
  String? get password;
  UserRole? get role;

  @override
  List<Object?> get props => [
    ...super.props,

    firstname,
    lastname,
    username,
    password,
    role,
  ];
  @override
  UserEntity copyWith({
    String? id,
    String? collectionId,
    DateTime? createdAt,
    DateTime? updatedAt,
    CopyWith<String?>? firstname,
    CopyWith<String?>? lastname,
    CopyWith<String?>? username,
    CopyWith<String?>? password,
    CopyWith<UserRole?>? role,

    Map<String, dynamic>? json,
  }) {
    return UserEntity(
      id: id ?? this.id,
      collectionId: collectionId ?? this.collectionId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      firstname: firstname != null ? firstname.value : this.firstname,
      lastname: lastname != null ? lastname.value : this.lastname,
      username: username != null ? username.value : this.username,
      password: password != null ? password.value : this.password,
      role: role != null ? role.value : this.role,
    );
  }
}
typedef UserEntityOrm =
    OrmEngine<UserEntity, UserEntityMeta, DbContext<UserEntity>>;

class UserEntityMeta extends EntityMeta<UserEntity> {
  const UserEntityMeta();

  @override
  String get tableName => 'user';

  @override
  ColumnDefinition<UserEntity, String> get id =>
      ColumnDefinition<UserEntity, String>(
        'id',
        primaryKey: true,
        write: (entity) => entity.id,
        read: (json, entity, value) => entity.copyWith(id: value, json: json),
      );

  @override
  ColumnDefinition<UserEntity, String> get collectionId =>
      ColumnDefinition<UserEntity, String>(
        'collectionId',
        write: (entity) => entity.collectionId,
        read:
            (json, entity, value) =>
                entity.copyWith(collectionId: value, json: json),
      );

  @override
  ColumnDefinition<UserEntity, DateTime> get createdAt =>
      ColumnDefinition<UserEntity, DateTime>(
        'createdAt',
        write: (entity) => entity.createdAt,
        read:
            (json, entity, value) =>
                entity.copyWith(createdAt: value, json: json),
      );

  @override
  ColumnDefinition<UserEntity, DateTime> get updatedAt =>
      ColumnDefinition<UserEntity, DateTime>(
        'updatedAt',
        write: (entity) => entity.updatedAt,
        read:
            (json, entity, value) =>
                entity.copyWith(updatedAt: value, json: json),
      );

  ColumnDefinition<UserEntity, String> get firstname =>
      ColumnDefinition<UserEntity, String>(
        'firstname',

        write: (entity) => entity.firstname,

        read:
            (json, entity, value) =>
                entity.copyWith(firstname: CopyWith(value), json: json),
      );

  ColumnDefinition<UserEntity, String> get lastname =>
      ColumnDefinition<UserEntity, String>(
        'lastname',

        write: (entity) => entity.lastname,

        read:
            (json, entity, value) =>
                entity.copyWith(lastname: CopyWith(value), json: json),
      );

  ColumnDefinition<UserEntity, String> get username =>
      ColumnDefinition<UserEntity, String>(
        'username',

        write: (entity) => entity.username,

        read:
            (json, entity, value) =>
                entity.copyWith(username: CopyWith(value), json: json),
      );

  ColumnDefinition<UserEntity, String> get password =>
      ColumnDefinition<UserEntity, String>(
        'password',

        write: (entity) => entity.password,

        read:
            (json, entity, value) =>
                entity.copyWith(password: CopyWith(value), json: json),
      );

  ColumnDefinition<UserEntity, String> get role =>
      ColumnDefinition<UserEntity, String>(
        'role',

        write: (entity) {
          if (entity.role == null) {
            return null;
          }
          final map = entity.role?.name;

          return map;
        },

        read: (json, entity, value) {
          return entity.readRole(json, value);
        },
      );

  @override
  Iterable<ColumnDefinition<UserEntity, dynamic>> get columns => [
    id,
    collectionId,
    createdAt,
    updatedAt,

    firstname,
    lastname,
    username,
    password,
    role,
  ];
}
