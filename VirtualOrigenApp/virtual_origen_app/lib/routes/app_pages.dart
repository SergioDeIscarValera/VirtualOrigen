import 'package:get/get.dart';
import 'package:virtual_origen_app/content/first_time/pages/first_time_page.dart';
import 'package:virtual_origen_app/content/first_time/storage/binding/first_time_binding.dart';
import 'package:virtual_origen_app/routes/app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.FIRST_TIME.path,
      page: () => const FirstTimePage(),
      binding: FirstTimeBinding(),
    )
  ];
}
