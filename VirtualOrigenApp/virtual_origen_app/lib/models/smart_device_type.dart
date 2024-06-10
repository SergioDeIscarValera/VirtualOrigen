import 'package:flutter/material.dart';

enum SmartDeviceType {
  LIGHT,
  SWITCH,
  BOILER,
  AIR_CONDITIONER,
  IRRIGATION,
  OTHER,
}

extension SmartDeviceTypeExtension on SmartDeviceType {
  String get token {
    switch (this) {
      case SmartDeviceType.LIGHT:
        return 'light';
      case SmartDeviceType.SWITCH:
        return 'switch';
      case SmartDeviceType.BOILER:
        return 'boiler';
      case SmartDeviceType.AIR_CONDITIONER:
        return 'air_conditioner';
      case SmartDeviceType.IRRIGATION:
        return 'irrigation';
      case SmartDeviceType.OTHER:
        return 'other';
    }
  }

  IconData get icon {
    switch (this) {
      case SmartDeviceType.LIGHT:
        return Icons.lightbulb;
      case SmartDeviceType.SWITCH:
        return Icons.power_settings_new;
      case SmartDeviceType.BOILER:
        return Icons.fireplace;
      case SmartDeviceType.AIR_CONDITIONER:
        return Icons.air;
      case SmartDeviceType.IRRIGATION:
        return Icons.water_drop_outlined;
      case SmartDeviceType.OTHER:
        return Icons.devices_other;
    }
  }
}
