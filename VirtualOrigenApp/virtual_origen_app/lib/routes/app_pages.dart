import 'package:get/get.dart';
import 'package:virtual_origen_app/content/auth/pages/email_validate_page.dart';
import 'package:virtual_origen_app/content/auth/pages/forgot_password_page.dart';
import 'package:virtual_origen_app/content/auth/pages/login_page.dart';
import 'package:virtual_origen_app/content/auth/pages/singin_page.dart';
import 'package:virtual_origen_app/content/auth/storage/binding/auth_binding.dart';
import 'package:virtual_origen_app/content/first_time/pages/first_time_page.dart';
import 'package:virtual_origen_app/content/first_time/storage/binding/first_time_binding.dart';
import 'package:virtual_origen_app/content/main/pages/home_page.dart';
import 'package:virtual_origen_app/content/main/pages/inversor_page.dart';
import 'package:virtual_origen_app/content/main/pages/property_page.dart';
import 'package:virtual_origen_app/content/main/pages/smart_device_page.dart';
import 'package:virtual_origen_app/content/main/pages/user_page.dart';
import 'package:virtual_origen_app/content/main/pages/weather_page.dart';
import 'package:virtual_origen_app/content/main/storage/binding/home_binding.dart';
import 'package:virtual_origen_app/content/main/storage/binding/inversor_binding.dart';
import 'package:virtual_origen_app/content/main/storage/binding/property_binding.dart';
import 'package:virtual_origen_app/content/main/storage/binding/smart_device_binding.dart';
import 'package:virtual_origen_app/content/main/storage/binding/user_binding.dart';
import 'package:virtual_origen_app/content/main/storage/binding/weather_binding.dart';
import 'package:virtual_origen_app/content/policy/pages/policy_page.dart';
import 'package:virtual_origen_app/routes/app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.FIRST_TIME.path,
      page: () => const FirstTimePage(),
      binding: FirstTimeBinding(),
    ),
    GetPage(
      name: Routes.LOGIN.path,
      page: () => const LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.SINGUP.path,
      page: () => const SingupPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.FORGOT_PASSWORD.path,
      page: () => const ForgotPasswordPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.EMAIL_VERIFICATION.path,
      page: () => const EmailValidatePage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.HOME.path,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.PROPERTY.path,
      page: () => const PropertyPage(),
      binding: PropertyBinding(),
      transition: Transition.noTransition,
      transitionDuration: Duration.zero,
    ),
    GetPage(
      name: Routes.SMART_DEVICE.path,
      page: () => const SmartDevicePage(),
      binding: SmartDeviceBinding(),
      transition: Transition.noTransition,
      transitionDuration: Duration.zero,
    ),
    GetPage(
      name: Routes.INVERSOR.path,
      page: () => const InversorPage(),
      binding: InversorBinding(),
      transition: Transition.noTransition,
      transitionDuration: Duration.zero,
    ),
    GetPage(
      name: Routes.WEATHER.path,
      page: () => const WeatherPage(),
      binding: WeatherBinding(),
      transition: Transition.noTransition,
      transitionDuration: Duration.zero,
    ),
    GetPage(
      name: Routes.USER.path,
      page: () => const UserPage(),
      binding: UserBinding(),
      transition: Transition.noTransition,
      transitionDuration: Duration.zero,
    ),
    GetPage(
      name: Routes.PRIVACY_POLICY.path,
      page: () => const PolicyPage(),
    ),
  ];
}
