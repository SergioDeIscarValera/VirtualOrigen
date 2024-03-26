import 'package:flutter/material.dart';
import 'package:get/get.dart';

/*
  --bs-primary: #78c2ad;
  --bs-secondary: #f3969a;
  --bs-success: #56cc9d;
  --bs-info: #6cc3d5;
  --bs-warning: #ffce67;
  --bs-danger: #ff7851;
  --bs-light: #f8f9fa;
  --bs-dark: #343a40;
*/

/*
  --bs-primary-text-emphasis: #304e45;
  --bs-secondary-text-emphasis: #613c3e;
  --bs-success-text-emphasis: #22523f;
  --bs-info-text-emphasis: #2b4e55;
  --bs-warning-text-emphasis: #665229;
  --bs-danger-text-emphasis: #663020;
  --bs-light-text-emphasis: #5a5a5a;
  --bs-dark-text-emphasis: #5a5a5a;
*/

enum MyColors {
  // Normales
  PRIMARY,
  SECONDARY,
  SUCCESS,
  INFO,
  WARNING,
  DANGER,
  LIGHT,
  DARK,

  // Otros
  ORANGE,
  PURPLE,
  PINK,

  // Énfasis
  PRIMARY_EMPHSIS,
  SECONDARY_EMPHSIS,
  SUCCESS_EMPHSIS,
  INFO_EMPHSIS,
  WARNING_EMPHSIS,
  DANGER_EMPHSIS,
  LIGHT_EMPHSIS,
  DARK_EMPHSIS,

  // Otros énfasis
  ORANGE_EMPHSIS,
  PURPLE_EMPHSIS,
  PINK_EMPHSIS,

  // Especiales
  CURRENT,
  CONTRARY,
}

extension MyColorsExten on MyColors {
  Color get color {
    switch (this) {
      case MyColors.PRIMARY:
        return const Color(0xFF78C2AD);
      case MyColors.SECONDARY:
        return const Color(0xFFF3969A);
      case MyColors.SUCCESS:
        return const Color(0xFF56CC9D);
      case MyColors.INFO:
        return const Color(0xFF6CC3D5);
      case MyColors.WARNING:
        return const Color(0xFFFFCE67);
      case MyColors.DANGER:
        return const Color(0xFFFF7851);
      case MyColors.LIGHT:
        return const Color(0xFFF8F9FA);
      case MyColors.DARK:
        return const Color(0xFF343A40);

      case MyColors.ORANGE:
        return const Color(0xFFfD7E14);
      case MyColors.PURPLE:
        return const Color(0xFF6F42C1);
      case MyColors.PINK:
        return const Color(0xFFE83E8C);

      case MyColors.PRIMARY_EMPHSIS:
        return const Color(0xFF304E45);
      case MyColors.SECONDARY_EMPHSIS:
        return const Color(0xFF613C3E);
      case MyColors.SUCCESS_EMPHSIS:
        return const Color(0xFF22523F);
      case MyColors.INFO_EMPHSIS:
        return const Color(0xFF2B4E55);
      case MyColors.WARNING_EMPHSIS:
        return const Color(0xFF665229);
      case MyColors.DANGER_EMPHSIS:
        return const Color(0xFF663020);
      case MyColors.LIGHT_EMPHSIS:
        return const Color(0xFF5A5A5A);
      case MyColors.DARK_EMPHSIS:
        return const Color(0xFF5A5A5A);

      case MyColors.ORANGE_EMPHSIS:
        return const Color(0xFFC96511);
      case MyColors.PURPLE_EMPHSIS:
        return const Color(0xFF321F56);
      case MyColors.PINK_EMPHSIS:
        return const Color(0xFF7B234C);

      case MyColors.CURRENT:
        return Get.isDarkMode ? MyColors.DARK.color : MyColors.LIGHT.color;
      case MyColors.CONTRARY:
        return Get.isDarkMode ? MyColors.LIGHT.color : MyColors.DARK.color;
    }
  }

  Color get inverse {
    switch (this) {
      case MyColors.PRIMARY:
        return MyColors.PRIMARY_EMPHSIS.color;
      case MyColors.SECONDARY:
        return MyColors.SECONDARY_EMPHSIS.color;
      case MyColors.SUCCESS:
        return MyColors.SUCCESS_EMPHSIS.color;
      case MyColors.INFO:
        return MyColors.INFO_EMPHSIS.color;
      case MyColors.WARNING:
        return MyColors.WARNING_EMPHSIS.color;
      case MyColors.DANGER:
        return MyColors.DANGER_EMPHSIS.color;
      case MyColors.LIGHT:
        return MyColors.LIGHT_EMPHSIS.color;
      case MyColors.DARK:
        return MyColors.DARK_EMPHSIS.color;

      case MyColors.ORANGE:
        return MyColors.ORANGE_EMPHSIS.color;
      case MyColors.PURPLE:
        return MyColors.PURPLE_EMPHSIS.color;
      case MyColors.PINK:
        return MyColors.PINK_EMPHSIS.color;

      case MyColors.PRIMARY_EMPHSIS:
        return MyColors.PRIMARY.color;
      case MyColors.SECONDARY_EMPHSIS:
        return MyColors.SECONDARY.color;
      case MyColors.SUCCESS_EMPHSIS:
        return MyColors.SUCCESS.color;
      case MyColors.INFO_EMPHSIS:
        return MyColors.INFO.color;
      case MyColors.WARNING_EMPHSIS:
        return MyColors.WARNING.color;
      case MyColors.DANGER_EMPHSIS:
        return MyColors.DANGER.color;
      case MyColors.LIGHT_EMPHSIS:
        return MyColors.LIGHT.color;
      case MyColors.DARK_EMPHSIS:
        return MyColors.DARK.color;

      case MyColors.ORANGE_EMPHSIS:
        return MyColors.ORANGE.color;
      case MyColors.PURPLE_EMPHSIS:
        return MyColors.PURPLE.color;
      case MyColors.PINK_EMPHSIS:
        return MyColors.PINK.color;

      case MyColors.CURRENT:
        return Get.isDarkMode
            ? MyColors.DARK_EMPHSIS.color
            : MyColors.LIGHT_EMPHSIS.color;
      case MyColors.CONTRARY:
        return Get.isDarkMode
            ? MyColors.LIGHT_EMPHSIS.color
            : MyColors.DARK_EMPHSIS.color;
    }
  }

  int get hex {
    switch (this) {
      case MyColors.PRIMARY:
        return 0xFF78C2AD;
      case MyColors.SECONDARY:
        return 0xFFF3969A;
      case MyColors.SUCCESS:
        return 0xFF56CC9D;
      case MyColors.INFO:
        return 0xFF6CC3D5;
      case MyColors.WARNING:
        return 0xFFFFCE67;
      case MyColors.DANGER:
        return 0xFFFF7851;
      case MyColors.LIGHT:
        return 0xFFF8F9FA;
      case MyColors.DARK:
        return 0xFF343A40;

      case MyColors.ORANGE:
        return 0xFFfD7E14;
      case MyColors.PURPLE:
        return 0xFF6F42C1;
      case MyColors.PINK:
        return 0xFFE83E8C;

      case MyColors.PRIMARY_EMPHSIS:
        return 0xFF304E45;
      case MyColors.SECONDARY_EMPHSIS:
        return 0xFF613C3E;
      case MyColors.SUCCESS_EMPHSIS:
        return 0xFF22523F;
      case MyColors.INFO_EMPHSIS:
        return 0xFF2B4E55;
      case MyColors.WARNING_EMPHSIS:
        return 0xFF665229;
      case MyColors.DANGER_EMPHSIS:
        return 0xFF663020;
      case MyColors.LIGHT_EMPHSIS:
        return 0xFF5A5A5A;
      case MyColors.DARK_EMPHSIS:
        return 0xFF5A5A5A;

      case MyColors.ORANGE_EMPHSIS:
        return 0xFFC96511;
      case MyColors.PURPLE_EMPHSIS:
        return 0xFF321F56;
      case MyColors.PINK_EMPHSIS:
        return 0xFF7B234C;

      case MyColors.CURRENT:
        return Get.isDarkMode ? MyColors.DARK.hex : MyColors.LIGHT.hex;
      case MyColors.CONTRARY:
        return Get.isDarkMode ? MyColors.LIGHT.hex : MyColors.DARK.hex;
    }
  }

  bool get isSelectable {
    switch (this) {
      case MyColors.PRIMARY:
      case MyColors.SECONDARY:
      case MyColors.SUCCESS:
      case MyColors.INFO:
      case MyColors.WARNING:
      case MyColors.DANGER:
      case MyColors.ORANGE:
      case MyColors.PURPLE:
      case MyColors.PINK:
        return true;
      default:
        return false;
    }
  }

  String get token {
    switch (this) {
      case MyColors.PRIMARY:
        return 'primary';
      case MyColors.SECONDARY:
        return 'secondary';
      case MyColors.SUCCESS:
        return 'success';
      case MyColors.INFO:
        return 'info';
      case MyColors.WARNING:
        return 'warning';
      case MyColors.DANGER:
        return 'danger';
      case MyColors.LIGHT:
        return 'light';
      case MyColors.DARK:
        return 'dark';

      case MyColors.ORANGE:
        return 'orange';
      case MyColors.PURPLE:
        return 'purple';
      case MyColors.PINK:
        return 'pink';

      case MyColors.PRIMARY_EMPHSIS:
        return 'primary-emphasis';
      case MyColors.SECONDARY_EMPHSIS:
        return 'secondary-emphasis';
      case MyColors.SUCCESS_EMPHSIS:
        return 'success-emphasis';
      case MyColors.INFO_EMPHSIS:
        return 'info-emphasis';
      case MyColors.WARNING_EMPHSIS:
        return 'warning-emphasis';
      case MyColors.DANGER_EMPHSIS:
        return 'danger-emphasis';
      case MyColors.LIGHT_EMPHSIS:
        return 'light-emphasis';
      case MyColors.DARK_EMPHSIS:
        return 'dark-emphasis';

      case MyColors.ORANGE_EMPHSIS:
        return 'orange-emphasis';
      case MyColors.PURPLE_EMPHSIS:
        return 'purple-emphasis';
      case MyColors.PINK_EMPHSIS:
        return 'pink-emphasis';

      case MyColors.CURRENT:
        return 'current';
      case MyColors.CONTRARY:
        return 'contrary';
    }
  }
}
