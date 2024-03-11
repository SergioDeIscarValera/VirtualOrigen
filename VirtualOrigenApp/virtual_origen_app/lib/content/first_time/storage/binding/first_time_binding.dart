import 'package:get/get.dart';
import 'package:virtual_origen_app/content/first_time/storage/controller/first_time_controller.dart';

class FirstTimeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FirstTimeController>(() => FirstTimeController());
  }
}
