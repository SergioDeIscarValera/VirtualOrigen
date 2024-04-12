import 'package:get/get.dart';
import 'package:virtual_origen_app/content/main/widgets/invitation_dialog.dart';
import 'package:virtual_origen_app/content/main/widgets/smart_device_dialog.dart';
import 'package:virtual_origen_app/models/inversor_now.dart';
import 'package:virtual_origen_app/models/invitation.dart';
import 'package:virtual_origen_app/models/invitation_permission.dart';
import 'package:virtual_origen_app/models/property.dart';
import 'package:virtual_origen_app/models/property_day_weather.dart';
import 'package:virtual_origen_app/models/smart_device.dart';
import 'package:virtual_origen_app/routes/app_routes.dart';
import 'package:virtual_origen_app/services/auth/interface_auth_service.dart';
import 'package:virtual_origen_app/services/repository/inversor_now/inversor_now_firebase_repository.dart';
import 'package:virtual_origen_app/services/repository/invitation/interface_invitation_repository.dart';
import 'package:virtual_origen_app/services/repository/property/interface_property_repository.dart';
import 'package:virtual_origen_app/services/repository/property_day_weather/property_day_weather_firebase_repository.dart';
import 'package:virtual_origen_app/services/repository/smart_device/interface_smart_device_repository.dart';
import 'package:virtual_origen_app/utils/my_snackbar.dart';
import 'package:virtual_origen_app/utils/validators/smart_device_validator.dart';

class PropertyController extends GetxController {
  late IPropertyRepository _propertyRepository;
  late ISmartDeviceRepository _smartDeviceRepository;
  late InversorNowFirebaseRepository _inversorNowRepository;
  late IInvitationRepository _invitationRepository;
  late IAuthService _authService;
  late MySnackbar _mySnackbar;
  late PropertyDayWeatherFirebaseRepository _propertyDayWeatherRepository;

  Rx<Property> propertySelected = Property.defaultConstructor().obs;
  late final String ownerUid;
  RxList<SmartDevice> smartDevices = <SmartDevice>[].obs;
  Rx<InversorNow> inversorNow = InversorNow.defaultConstructor().obs;
  Rx<PropertyHourWeather> weatherNow =
      PropertyHourWeather.defaultConstructor().obs;

  RxBool isMenuOpen = false.obs;

  @override
  void onInit() {
    _mySnackbar = Get.find<MySnackbar>();
    _authService = Get.find<IAuthService>();
    _propertyRepository = Get.find<IPropertyRepository>();
    _inversorNowRepository = Get.find<InversorNowFirebaseRepository>();
    _smartDeviceRepository = Get.find<ISmartDeviceRepository>();
    _propertyDayWeatherRepository =
        Get.find<PropertyDayWeatherFirebaseRepository>();
    _invitationRepository = Get.find<IInvitationRepository>();
    super.onInit();
  }

  @override
  void onClose() {
    _smartDeviceRepository.removeListener(idc: propertySelected.value.id);
    _propertyDayWeatherRepository.removeListener(
        idc: propertySelected.value.id);
    _inversorNowRepository.removeListener(idc: propertySelected.value.id);
    super.onClose();
  }

  void setPropertySelected(Property? propertySelected, String? ownerUid) {
    if (propertySelected == null || ownerUid == null) {
      Get.back();
      return;
    }
    this.ownerUid = ownerUid;
    // Property
    _propertyRepository.addSingleListener(
      id: propertySelected.id,
      idc: ownerUid,
      listener: (value) {
        this.propertySelected.value = value ?? Property.defaultConstructor();
      },
    );
    // Weather
    _propertyDayWeatherRepository.addHourlyListener(
      idc: propertySelected.id,
      listener: (value) {
        weatherNow.value = value;
      },
    );
    // Smart Devices
    _smartDeviceRepository.addListener(
      idc: propertySelected.id,
      listener: (smartDevices) {
        this.smartDevices.value = smartDevices;
      },
    );
  }

  void newSmartDeviceDialog() {
    _openDialog(null);
  }

  void dropdowMenu() {
    isMenuOpen.value = !isMenuOpen.value;
    if (isMenuOpen.value) {
      _inversorNowRepository.addListener(
          idc: propertySelected.value.id,
          listener: (value) {
            inversorNow.value = value.first;
          });
    } else {
      inversorNow.value = InversorNow.defaultConstructor();
      _inversorNowRepository.removeListener(idc: propertySelected.value.id);
    }
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
            idc: propertySelected.value.id,
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
            idc: propertySelected.value.id,
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
      idc: propertySelected.value.id,
    );
  }

  void openWeatherPage() {
    final args = {
      "property": propertySelected.value,
    };
    Get.toNamed(Routes.WEATHER.path, arguments: args);
  }

  void openInversorPage() {
    final args = {
      "property": propertySelected.value,
    };
    Get.toNamed(Routes.INVERSOR.path, arguments: args);
  }

  void openInvitationDialog() {
    Get.dialog(
      InvitationDialog(
        onSendInvitation: (email, invitationPermission) async {
          if (email == _authService.getEmail()) {
            _mySnackbar.snackWarning("invitation_yourself".tr);
            return;
          }

          if (propertySelected.value.guests
              .any((element) => element.guestEmail == email)) {
            _mySnackbar.snackWarning("invitation_already_sent".tr);
            return;
          }

          final invitation = Invitation(
            fromEmail: _authService.getEmail(),
            fromProfileImage: _authService.getProfileImage(),
            ownerId: ownerUid,
            propertyName: propertySelected.value.name,
            propertyId: propertySelected.value.id,
            state: false, // Pending
            isNew: true,
          );
          final propertyGuest = PropertyGuest(
              guestEmail: email,
              permission: invitationPermission,
              guestProfileImage: "",
              state: 0 // Pending
              );
          final newProperty = propertySelected.value.copyWith(
            guests: [...propertySelected.value.guests, propertyGuest],
          );

          // Actualizar la lista de invitados en la propiedad
          dynamic result = await _propertyRepository.save(
            entity: newProperty,
            idc: ownerUid,
          );
          if (result == null) {
            _mySnackbar.snackError("invitation_not_sent".tr);
            return;
          }
          // Enviar la invitación al invitado
          result = await _invitationRepository.save(
            entity: invitation,
            idc: email,
          );
          if (result != null) {
            Get.back();
            _mySnackbar.snackSuccess("invitation_sent".tr);
          } else {
            _mySnackbar.snackError("invitation_not_sent".tr);
          }
        },
      ),
    );
  }

  void changeGuestPermission(
      String guestEmail, InvitationPermission permission) async {
    final newProperty = propertySelected.value.copyWith(
      guests: propertySelected.value.guests.map((e) {
        if (e.guestEmail == guestEmail) {
          return e.copyWith(permission: permission);
        }
        return e;
      }).toList(),
    );
    final result = await _propertyRepository.save(
      entity: newProperty,
      idc: ownerUid,
    );
    if (result != null) {
      Get.back();
      _mySnackbar.snackSuccess("guest_permission_changed".tr);
    } else {
      _mySnackbar.snackError("guest_permission_not_changed".tr);
    }
  }

  void removeGuest(String guestEmail) {
    final newProperty = propertySelected.value.copyWith(
      guests: propertySelected.value.guests
          .where((element) => element.guestEmail != guestEmail)
          .toList(),
    );
    _propertyRepository.save(
      entity: newProperty,
      idc: ownerUid,
    );
    _invitationRepository.deleteById(
      id: propertySelected.value.id,
      idc: guestEmail,
    );
    Get.back();
  }
}
