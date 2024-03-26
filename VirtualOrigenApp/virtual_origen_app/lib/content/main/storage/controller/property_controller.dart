import 'package:get/get.dart';
import 'package:virtual_origen_app/content/main/widgets/smart_device_dialog.dart';
import 'package:virtual_origen_app/models/inversor_now.dart';
import 'package:virtual_origen_app/models/property.dart';
import 'package:virtual_origen_app/models/smart_device.dart';
import 'package:virtual_origen_app/routes/app_routes.dart';
import 'package:virtual_origen_app/services/auth/interface_auth_service.dart';
import 'package:virtual_origen_app/services/repository/inversor_now/inversor_now_firebase_repository.dart';
import 'package:virtual_origen_app/services/repository/smart_device/interface_smart_device_repository.dart';
import 'package:virtual_origen_app/utils/my_snackbar.dart';
import 'package:virtual_origen_app/utils/validators/smart_device_validator.dart';

class PropertyController extends GetxController {
  late ISmartDeviceRepository _smartDeviceRepository;
  late InversorNowFirebaseRepository _inversorNowRepository;
  late IAuthService _authService;
  late MySnackbar _mySnackbar;

  Rx<Property> propertySelected = Property.defaultConstructor().obs;
  RxList<SmartDevice> smartDevices = <SmartDevice>[].obs;
  Rx<InversorNow> inversorNow = InversorNow.defaultConstructor().obs;

  RxBool isMenuOpen = false.obs;

  @override
  void onInit() {
    _mySnackbar = Get.find<MySnackbar>();
    _authService = Get.find<IAuthService>();
    _inversorNowRepository = Get.find<InversorNowFirebaseRepository>();
    _smartDeviceRepository = Get.find<ISmartDeviceRepository>();
    super.onInit();
  }

  @override
  void onClose() {
    _smartDeviceRepository.removeListener(idc: _authService.getUid());
    super.onClose();
  }

  void setPropertySelected(Property? propertySelected) {
    if (propertySelected == null) {
      Get.back();
      return;
    }
    this.propertySelected.value = propertySelected;
    _setUpList();
  }

  void newSmartDeviceDialog() {
    _openDialog(null);
  }

  void dropdowMenu() {
    isMenuOpen.value = !isMenuOpen.value;
    if (isMenuOpen.value) {
      _inversorNowRepository.addListener(
          idc: _authService.getUid(),
          listener: (value) {
            inversorNow.value = value.first;
          });
    } else {
      inversorNow.value = InversorNow.defaultConstructor();
      _inversorNowRepository.removeListener(idc: _authService.getUid());
    }
  }

  void _setUpList() {
    _smartDeviceRepository.addListener(
      idc: _authService.getUid(),
      listener: (smartDevices) {
        this.smartDevices.value = smartDevices;
      },
    );
  }

  void navigateSmartDeviceDetails(SmartDevice smartDevice) {}

  void editSmartDeviceDialog(SmartDevice smartDevice) {
    _openDialog(smartDevice);
  }

  void _openDialog(SmartDevice? smartDevice) {
    Get.dialog(
      SmartDeviceDialog(
        smartDevice: smartDevice,
        onSave: (smartDevice) async {
          if (!SmartDeviceValidator.isValidSmartDevice(
              smartDevice: smartDevice)) {
            _mySnackbar.snackWarning("smart_device_invalid".tr);
            return;
          }
          var result = await _smartDeviceRepository.save(
            entity: smartDevice,
            idc: _authService.getUid(),
          );
          if (result != null) {
            Get.back();
            _mySnackbar.snackSuccess("smart_device_saved".tr);
          } else {
            _mySnackbar.snackError("smart_device_not_saved".tr);
          }
        },
        onDelete: (smartDevice) {
          _smartDeviceRepository.deleteById(
            id: smartDevice.id,
            idc: _authService.getUid(),
          );
          Get.back();
        },
      ),
    );
  }

  void changeManualMode(SmartDevice smartDevice, bool value) {
    var newSmartDevice = smartDevice.copyWith(isManualMode: value);
    _smartDeviceRepository.save(
      entity: newSmartDevice,
      idc: _authService.getUid(),
    );
  }

  void openWeatherPage() {
    var args = {
      "property": propertySelected.value,
    };
    Get.toNamed(Routes.WEATHER.path, arguments: args);
  }

  void openInversorPage() {
    var args = {
      "property": propertySelected.value,
    };
    Get.toNamed(Routes.INVERSOR.path, arguments: args);
  }
}
