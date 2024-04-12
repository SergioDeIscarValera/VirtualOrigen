import 'package:get/get.dart';
import 'package:virtual_origen_app/content/main/storage/controller/inversor_controller.dart';
import 'package:virtual_origen_app/services/auth/auth_service_firebase.dart';
import 'package:virtual_origen_app/services/auth/interface_auth_service.dart';
import 'package:virtual_origen_app/services/repository/inversor_now/inversor_now_firebase_repository.dart';
import 'package:virtual_origen_app/services/repository/inversor_yesterday/inversor_yesterday_firebase_repository.dart';

class InversorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InversorController>(() => InversorController());

    Get.lazyPut(() => InversorNowFirebaseRepository());
    Get.lazyPut(() => InversorYerserdayFirebaseRepository());
    Get.lazyPut<IAuthService>(() => AuthServiceFirebase());
  }
}
