import 'package:get/get.dart';
import 'package:virtual_origen_app/content/main/storage/controller/smart_device_controller.dart';

class SmartDeviceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SmartDeviceController>(() => SmartDeviceController());
  }
}
