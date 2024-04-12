import 'package:get/get.dart';
import 'package:virtual_origen_app/content/main/storage/controller/user_controller.dart';
import 'package:virtual_origen_app/services/auth/auth_service_firebase.dart';
import 'package:virtual_origen_app/services/auth/interface_auth_service.dart';
import 'package:virtual_origen_app/services/repository/invitation/interface_invitation_repository.dart';
import 'package:virtual_origen_app/services/repository/invitation/invitation_firebase_repository.dart';
import 'package:virtual_origen_app/services/repository/property/interface_property_repository.dart';
import 'package:virtual_origen_app/services/repository/property/property_firebase_repository.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserController>(() => UserController());

    Get.lazyPut<IAuthService>(() => AuthServiceFirebase());
    Get.lazyPut<IInvitationRepository>(() => InvitationFirebaseRepository());
    Get.lazyPut<IPropertyRepository>(() => PropertyFirebaseRepository());
  }
}
