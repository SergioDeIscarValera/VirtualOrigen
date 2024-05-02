import 'package:get/get.dart';
import 'package:virtual_origen_app/content/main/storage/controller/property_controller.dart';
import 'package:virtual_origen_app/services/auth/auth_service_firebase.dart';
import 'package:virtual_origen_app/services/auth/interface_auth_service.dart';
import 'package:virtual_origen_app/services/repository/inversor_now/inversor_now_firebase_repository.dart';
import 'package:virtual_origen_app/services/repository/property/interface_property_repository.dart';
import 'package:virtual_origen_app/services/repository/property/property_firebase_repository.dart';
import 'package:virtual_origen_app/services/repository/property_day_weather/property_day_weather_firebase_repository.dart';
import 'package:virtual_origen_app/services/repository/scene/interface_scene_repository.dart';
import 'package:virtual_origen_app/services/repository/scene/scene_firebase_repository.dart';
import 'package:virtual_origen_app/services/repository/smart_device/interface_smart_device_repository.dart';
import 'package:virtual_origen_app/services/repository/smart_device/smart_device_firebase_repository.dart';
import 'package:virtual_origen_app/utils/my_snackbar.dart';

class PropertyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PropertyController>(() => PropertyController());

    Get.lazyPut<IPropertyRepository>(() => PropertyFirebaseRepository());
    Get.lazyPut<ISmartDeviceRepository>(() => SmartDeviceFirebaseRepository());
    Get.lazyPut<ISceneRepository>(() => SceneFirebaseRepository());
    Get.lazyPut(() => InversorNowFirebaseRepository());
    Get.lazyPut<IAuthService>(() => AuthServiceFirebase());
    Get.lazyPut(() => MySnackbar());
    Get.lazyPut(() => PropertyDayWeatherFirebaseRepository());
  }
}
