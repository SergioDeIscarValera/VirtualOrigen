import 'package:get/get.dart';
import 'package:virtual_origen_app/content/main/storage/controller/home_controller.dart';
import 'package:virtual_origen_app/services/auth/auth_service_firebase.dart';
import 'package:virtual_origen_app/services/auth/interface_auth_service.dart';
import 'package:virtual_origen_app/services/repository/inversor_now/inversor_now_firebase_repository.dart';
import 'package:virtual_origen_app/services/repository/invitation/interface_invitation_repository.dart';
import 'package:virtual_origen_app/services/repository/invitation/invitation_firebase_repository.dart';
import 'package:virtual_origen_app/services/repository/property/interface_property_repository.dart';
import 'package:virtual_origen_app/services/repository/property/property_firebase_repository.dart';
import 'package:virtual_origen_app/services/repository/property_day_weather/property_day_weather_firebase_repository.dart';
import 'package:virtual_origen_app/utils/my_snackbar.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());

    Get.lazyPut<IPropertyRepository>(() => PropertyFirebaseRepository());
    Get.lazyPut(() => InversorNowFirebaseRepository());
    Get.lazyPut(() => PropertyDayWeatherFirebaseRepository());
    Get.lazyPut<IInvitationRepository>(() => InvitationFirebaseRepository());
    Get.lazyPut<IAuthService>(() => AuthServiceFirebase());
    Get.lazyPut(() => MySnackbar());
  }
}
