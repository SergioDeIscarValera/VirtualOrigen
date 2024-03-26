import 'package:get/get.dart';
import 'package:virtual_origen_app/content/main/storage/controller/weather_controller.dart';

class WeatherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WeatherController>(() => WeatherController());
  }
}
