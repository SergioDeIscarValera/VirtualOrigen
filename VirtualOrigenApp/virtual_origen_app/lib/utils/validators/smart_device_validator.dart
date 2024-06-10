import 'package:virtual_origen_app/models/smart_device.dart';

class SmartDeviceValidator {
  static bool isValidSmartDevice({required SmartDevice smartDevice}) {
    return smartDevice.name.trim().isNotEmpty &&
        smartDevice.timeZones.isNotEmpty &&
        smartDevice.days.length == 7 &&
        (smartDevice.batteryRange?.key ?? 0) >= 0 &&
        (smartDevice.batteryRange?.value ?? 100) <= 100 &&
        (smartDevice.productionRange?.key ?? 0) >= 0 &&
        (smartDevice.productionRange?.value ?? 9999) <= 9999 &&
        (smartDevice.consumptionRange?.key ?? 0) >= 0 &&
        (smartDevice.consumptionRange?.value ?? 9999) <= 9999 &&
        (smartDevice.temperatureRange?.key ?? -20) >= -20 &&
        (smartDevice.temperatureRange?.value ?? 60) <= 60 &&
        (smartDevice.rainRange?.key ?? 0) >= 0 &&
        (smartDevice.rainRange?.value ?? 100) <= 100;
  }
}
