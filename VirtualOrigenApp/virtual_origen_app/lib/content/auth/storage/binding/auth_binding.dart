import 'package:get/get.dart';
import 'package:virtual_origen_app/content/auth/storage/controller/auth_controller.dart';
import 'package:virtual_origen_app/services/auth/auth_service_firebase.dart';
import 'package:virtual_origen_app/services/auth/interface_auth_service.dart';
import 'package:virtual_origen_app/utils/form_validator.dart';
import 'package:virtual_origen_app/utils/my_snackbar.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<IAuthService>(() => AuthServiceFirebase());
    Get.lazyPut(() => MySnackbar());
    Get.lazyPut(() => FormValidator());
  }
}
