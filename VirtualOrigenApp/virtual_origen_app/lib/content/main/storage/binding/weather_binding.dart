import 'package:get/get.dart';
import 'package:virtual_origen_app/content/main/storage/controller/weather_controller.dart';
import 'package:virtual_origen_app/services/repository/property_day_weather/property_day_weather_firebase_repository.dart';

class WeatherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WeatherController>(() => WeatherController());

    Get.lazyPut(() => PropertyDayWeatherFirebaseRepository());
  }
}
