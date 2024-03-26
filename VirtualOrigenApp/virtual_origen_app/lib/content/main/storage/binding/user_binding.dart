import 'package:get/get.dart';
import 'package:virtual_origen_app/content/main/storage/controller/user_controller.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserController>(() => UserController());
  }
}
