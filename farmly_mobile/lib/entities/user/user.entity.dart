import 'package:flora_orm/flora_orm.dart';

import '../../constants/user_role.dart';

part 'user.entity.g.dart';
part 'user.entity.migrations.dart';

@OrmEntity(tableName: 'user')
class UserEntity extends Entity<UserEntity, UserEntityMeta>
    with _UserEntityMixin, UserEntityMigrations {

  const UserEntity({
    super.id,
    super.collectionId,
    super.createdAt,
    super.updatedAt,
    this.firstname,
    this.lastname,
    this.username,
    this.password,
    this.role,
  });

  @override
  @column
  final String? firstname;

  @override
  @column
  final String? lastname;
  @override
  @column
  final String? username;

  @override
  @column
  final String? password;

  @override
  @column
  final UserRole? role;
}