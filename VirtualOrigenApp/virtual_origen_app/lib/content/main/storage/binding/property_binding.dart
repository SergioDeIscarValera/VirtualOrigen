import 'package:get/get.dart';
import 'package:virtual_origen_app/content/main/storage/controller/property_controller.dart';

class PropertyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PropertyController>(() => PropertyController());
  }
}
