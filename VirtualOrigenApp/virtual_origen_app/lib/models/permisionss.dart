enum Permissionss {
  READ,
  WRITE,
  FULL,
}

extension PermissionssExtension on Permissionss {
  String get token {
    switch (this) {
      case Permissionss.READ:
        return 'read';
      case Permissionss.WRITE:
        return 'write';
      case Permissionss.FULL:
        return 'full';
    }
  }
}
