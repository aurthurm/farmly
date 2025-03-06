enum UserRole {
  CLERK,
  ADMIN,
}

extension UserRoleExtension on UserRole {
  String get name {
    switch (this) {
      case UserRole.CLERK:
        return "clerk";
      case UserRole.ADMIN:
        return "admin";
      default:
        return "";
    }
  }

  static UserRole fromString(String role) {
    switch (role) {
      case "clerk":
        return UserRole.CLERK;
      case "admin":
        return UserRole.ADMIN;
      default:
        return UserRole.CLERK;
    }
  }
}
