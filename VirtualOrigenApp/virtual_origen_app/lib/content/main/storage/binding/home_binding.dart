import 'package:get/get.dart';
import 'package:virtual_origen_app/content/main/storage/controller/home_controller.dart';
import 'package:virtual_origen_app/services/repository/inversor_now/inversor_now_firebase_repository.dart';
import 'package:virtual_origen_app/services/repository/inversor_yesterday/inversor_yesterday_firebase_repository.dart';
import 'package:virtual_origen_app/services/repository/invitation/interface_invitation_repository.dart';
import 'package:virtual_origen_app/services/repository/invitation/invitation_firebase_repository.dart';
import 'package:virtual_origen_app/services/repository/property/interface_property_repository.dart';
import 'package:virtual_origen_app/services/repository/property/property_firebase_repository.dart';
import 'package:virtual_origen_app/services/repository/smart_device/interface_smart_device_repository.dart';
import 'package:virtual_origen_app/services/repository/smart_device/smart_device_firebase_repository.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());

    Get.put<ISmartDeviceRepository>(SmartDeviceFirebaseRepository(),
        permanent: true);
    Get.put<IPropertyRepository>(PropertyFirebaseRepository(), permanent: true);
    Get.put<IInvitationRepository>(InvitationFirebaseRepository(),
        permanent: true);
    Get.put(InversorNowFirebaseRepository(), permanent: true);
    Get.put(InversorYerserdayFirebaseRepository(), permanent: true);
  }
}
