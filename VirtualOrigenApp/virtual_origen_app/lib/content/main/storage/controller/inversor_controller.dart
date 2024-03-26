import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
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

  Rx<Property> propertySelected = Property.defaultConstructor().obs;
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
    // _inversorYerserdayRepository.addListener(
    //   idc: _authService.getUid(),
    //   listener: (value) {
    //     inversorYerserday.value = value;
    //   },
    // );
    var datetime = DateTime.parse('2000-01-01T00:00:00');
    inversorYerserday.value = [
      InversorYerserday(
        propertyId: '1',
        battery: 80,
        consumption: 1200,
        gain: 1500,
        dateTime: datetime,
      ),
      InversorYerserday(
        propertyId: '2',
        battery: 79,
        consumption: 1200,
        gain: 1100,
        dateTime: datetime.subtract(const Duration(minutes: 15)),
      ),
      InversorYerserday(
        propertyId: '3',
        battery: 78,
        consumption: 2200,
        gain: 1000,
        dateTime: datetime.subtract(const Duration(minutes: 30)),
      ),
      InversorYerserday(
        propertyId: '4',
        battery: 77,
        consumption: 1200,
        gain: 900,
        dateTime: datetime.subtract(const Duration(minutes: 45)),
      ),
      InversorYerserday(
        propertyId: '5',
        battery: 76,
        consumption: 1260,
        gain: 1167,
        dateTime: datetime.subtract(const Duration(minutes: 60)),
      ),
      InversorYerserday(
        propertyId: '6',
        battery: 75,
        consumption: 2205,
        gain: 1006,
        dateTime: datetime.subtract(const Duration(minutes: 75)),
      ),
      InversorYerserday(
        propertyId: '7',
        battery: 74,
        consumption: 1234,
        gain: 905,
        dateTime: datetime.subtract(const Duration(minutes: 90)),
      ),
      InversorYerserday(
        propertyId: '8',
        battery: 73,
        consumption: 1267,
        gain: 1121,
        dateTime: datetime.subtract(const Duration(minutes: 105)),
      ),
      InversorYerserday(
        propertyId: '9',
        battery: 72,
        consumption: 2245,
        gain: 1014,
        dateTime: datetime.subtract(const Duration(minutes: 120)),
      ),
      InversorYerserday(
        propertyId: '10',
        battery: 71,
        consumption: 1200,
        gain: 900,
        dateTime: datetime.subtract(const Duration(minutes: 135)),
      ),
      InversorYerserday(
        propertyId: '11',
        battery: 70,
        consumption: 1200,
        gain: 1100,
        dateTime: datetime.subtract(const Duration(minutes: 150)),
      ),
      InversorYerserday(
        propertyId: '12',
        battery: 69,
        consumption: 2200,
        gain: 1000,
        dateTime: datetime.subtract(const Duration(minutes: 165)),
      ),
      InversorYerserday(
        propertyId: '13',
        battery: 68,
        consumption: 1200,
        gain: 900,
        dateTime: datetime.subtract(const Duration(minutes: 180)),
      ),
    ];
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
