import 'package:flutter/material.dart';
import 'package:virtual_origen_app/themes/colors.dart';

enum InvitationPermission {
  READ,
  WRITE,
  FULL,
}

extension InvitationPermissionExtension on InvitationPermission {
  String get token {
    switch (this) {
      case InvitationPermission.READ:
        return 'read';
      case InvitationPermission.WRITE:
        return 'write';
      case InvitationPermission.FULL:
        return 'full';
    }
  }

  IconData get icon {
    switch (this) {
      case InvitationPermission.READ:
        return Icons.remove_red_eye;
      case InvitationPermission.WRITE:
        return Icons.edit;
      case InvitationPermission.FULL:
        return Icons.vpn_key;
    }
  }

  MyColors get color {
    switch (this) {
      case InvitationPermission.READ:
        return MyColors.SUCCESS;
      case InvitationPermission.WRITE:
        return MyColors.WARNING;
      case InvitationPermission.FULL:
        return MyColors.PURPLE;
    }
  }
}
