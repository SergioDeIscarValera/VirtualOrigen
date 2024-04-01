import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:virtual_origen_app/models/inversor_now.dart';
import 'package:virtual_origen_app/models/inversor_yesterday.dart';
import 'package:virtual_origen_app/models/property.dart';
import 'package:virtual_origen_app/services/auth/interface_auth_service.dart';
import 'package:virtual_origen_app/services/repository/inversor_now/inversor_now_firebase_repository.dart';
import 'package:virtual_origen_app/services/repository/inversor_yesterday/inversor_yesterday_firebase_repository.dart';

class InversorController extends GetxController {
  late final InversorNowFirebaseRepository _inversorNowRepository;
  late final InversorYerserdayFirebaseRepository _inversorYerserdayRepository;
  late final IAuthService _authService;

  final Rx<Property> propertySelected = Property.defaultConstructor().obs;
  Rx<InversorNow> inversorNow = InversorNow.defaultConstructor().obs;
  RxList<InversorYerserday> inversorYerserday = <InversorYerserday>[].obs;
  RxList<FlSpot> batteryData = <FlSpot>[].obs;
  RxList<FlSpot> gainData = <FlSpot>[].obs;
  RxList<FlSpot> consumptionData = <FlSpot>[].obs;
  RxInt offsetBatteryChart = 0.obs;

  @override
  void onInit() {
    _authService = Get.find<IAuthService>();
    _inversorNowRepository = Get.find<InversorNowFirebaseRepository>();
    _inversorYerserdayRepository =
        Get.find<InversorYerserdayFirebaseRepository>();
    inversorYerserday.listen((value) {
      _setBatteryData(value);
      _setGainData(value);
      _setConsumptionData(value);
      offsetBatteryChart.value = value.length;
    });
    super.onInit();
  }

  @override
  void onClose() {
    _inversorNowRepository.removeListener(idc: _authService.getUid());
    _inversorYerserdayRepository.removeListener(idc: _authService.getUid());
    super.onClose();
  }

  void setPropertySelected(Property? propertySelected) {
    if (propertySelected == null) {
      Get.back();
      return;
    }
    this.propertySelected.value = propertySelected;
    _setUpInversorNow();
    _setUpInversorYerserday();
  }

  void _setUpInversorNow() {
    _inversorNowRepository.addListener(
      idc: _authService.getUid(),
      listener: (value) {
        inversorNow.value = value.first;
      },
    );
  }

  void _setUpInversorYerserday() {
    _inversorYerserdayRepository.addListener(
      idc: _authService.getUid(),
      listener: (value) {
        inversorYerserday.value = value;
      },
    );
  }

  void _setBatteryData(List<InversorYerserday> value) {
    batteryData.clear();
    value.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    for (int i = 0; i < value.length; i++) {
      // battery 0-100
      batteryData.add(FlSpot(i.toDouble(), value[i].battery));
    }
  }

  void _setGainData(List<InversorYerserday> value) {
    gainData.clear();
    value.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    for (int i = 0; i < value.length; i++) {
      // gain 0-9999
      gainData.add(FlSpot(i.toDouble(), value[i].gain.toDouble() / 100));
    }
  }

  void _setConsumptionData(List<InversorYerserday> value) {
    consumptionData.clear();
    value.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    for (int i = 0; i < value.length; i++) {
      // consumption 0-9999
      consumptionData
          .add(FlSpot(i.toDouble(), value[i].consumption.toDouble() / 100));
    }
  }
}
