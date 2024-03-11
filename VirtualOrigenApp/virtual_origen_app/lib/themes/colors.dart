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

  // Énfasis
  PRIMARY_EMPHSIS,
  SECONDARY_EMPHSIS,
  SUCCESS_EMPHSIS,
  INFO_EMPHSIS,
  WARNING_EMPHSIS,
  DANGER_EMPHSIS,
  LIGHT_EMPHSIS,
  DARK_EMPHSIS,

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

      case MyColors.CURRENT:
        return Get.isDarkMode ? MyColors.DARK.hex : MyColors.LIGHT.hex;
      case MyColors.CONTRARY:
        return Get.isDarkMode ? MyColors.LIGHT.hex : MyColors.DARK.hex;
    }
  }
}
