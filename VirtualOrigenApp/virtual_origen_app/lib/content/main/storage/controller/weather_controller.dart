import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:virtual_origen_app/models/property.dart';
import 'package:virtual_origen_app/models/property_day_weather.dart';
import 'package:virtual_origen_app/services/repository/property_day_weather/property_day_weather_firebase_repository.dart';

class WeatherController extends GetxController {
  late final PropertyDayWeatherFirebaseRepository _propertyDayWeatherRepository;

  final Rx<Property> propertySelected = Property.defaultConstructor().obs;
  final Rx<PropertyHourWeather> weatherNow =
      PropertyHourWeather.defaultConstructor().obs;
  final RxList<PropertyHourWeather> weatherList = <PropertyHourWeather>[].obs;
  final RxList<FlSpot> temData = <FlSpot>[].obs;
  final RxList<FlSpot> rainData = <FlSpot>[].obs;
  final RxList<FlSpot> windSpeedData = <FlSpot>[].obs;
  final RxInt offsetWeatherChart = 0.obs;

  @override
  void onInit() {
    _propertyDayWeatherRepository =
        Get.find<PropertyDayWeatherFirebaseRepository>();
    weatherList.listen((value) {
      temData.clear();
      rainData.clear();
      windSpeedData.clear();
      for (var e in value) {
        temData.add(FlSpot(1, e.temperature));
        rainData.add(FlSpot(1, e.rainProbability));
        windSpeedData.add(FlSpot(1, e.windSpeed));
      }
      offsetWeatherChart.value = value.length;
    });
    super.onInit();
  }

  @override
  void onClose() {
    _propertyDayWeatherRepository.removeListener(
        idc: propertySelected.value.id);
    _propertyDayWeatherRepository.removeHourlyListener(
        idc: propertySelected.value.id);
    super.onClose();
  }

  void setPropertySelected(Property? propertySelected) {
    if (propertySelected == null) {
      Get.back();
      return;
    }
    this.propertySelected.value = propertySelected;
    _propertyDayWeatherRepository.addHourlyListener(
        idc: propertySelected.id,
        listener: (value) {
          weatherNow.value = value;
        });
    _setUpWeatherList();
  }

  void _setUpWeatherList() {
    _propertyDayWeatherRepository.addListener(
      idc: propertySelected.value.id,
      listener: (value) {
        weatherList.value = value;
      },
    );
  }
}
