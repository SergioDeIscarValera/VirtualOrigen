import 'package:get/get.dart';
import 'package:virtual_origen_app/content/main/storage/controller/inversor_controller.dart';
import 'package:virtual_origen_app/services/auth/auth_service_firebase.dart';
import 'package:virtual_origen_app/services/auth/interface_auth_service.dart';

class InversorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InversorController>(() => InversorController());
    Get.lazyPut<IAuthService>(() => AuthServiceFirebase());
  }
}
