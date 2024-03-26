import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum SmartDeviceType {
  LIGHT,
  BOILER,
  AIR_CONDITIONER,
  HEADER,
  IRRIGATION,
  OTHER
}

extension SmartDeviceTypeExtension on SmartDeviceType {
  String get token {
    switch (this) {
      case SmartDeviceType.LIGHT:
        return 'light';
      case SmartDeviceType.BOILER:
        return 'boiler';
      case SmartDeviceType.AIR_CONDITIONER:
        return 'air_conditioner';
      case SmartDeviceType.HEADER:
        return 'header';
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
      case SmartDeviceType.BOILER:
        return Icons.fireplace;
      case SmartDeviceType.AIR_CONDITIONER:
        return Icons.air;
      case SmartDeviceType.HEADER:
        return Icons.water;
      case SmartDeviceType.IRRIGATION:
        return Icons.water_drop_outlined;
      case SmartDeviceType.OTHER:
        return Icons.devices_other;
    }
  }
}
