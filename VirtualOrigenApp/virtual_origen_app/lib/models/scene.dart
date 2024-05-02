import 'package:uuid/uuid.dart';
import 'package:virtual_origen_app/models/smart_device.dart';
import 'package:virtual_origen_app/models/smart_device_type.dart';
import 'package:virtual_origen_app/themes/colors.dart';

class Scene {
  final String id;
  final String name;
  final MyColors color;
  final SmartDeviceType type;
  final List<SmartDevice> devicesConfig;

  Scene({
    String? id,
    required this.name,
    required this.color,
    required this.type,
    required this.devicesConfig,
  }) : id = id ?? const Uuid().v4();
}
