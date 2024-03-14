import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_origen_app/content/auth/pages/email_validate_page.dart';
import 'package:virtual_origen_app/content/auth/pages/forgot_password_page.dart';
import 'package:virtual_origen_app/content/auth/pages/login_page.dart';
import 'package:virtual_origen_app/content/auth/pages/singin_page.dart';
import 'package:virtual_origen_app/content/first_time/pages/first_time_page.dart';
import 'package:virtual_origen_app/content/first_time/storage/binding/first_time_binding.dart';
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
    ),
    GetPage(
      name: Routes.SINGUP.path,
      page: () => const SingupPage(),
    ),
    GetPage(
      name: Routes.FORGOT_PASSWORD.path,
      page: () => const ForgotPasswordPage(),
    ),
    GetPage(
      name: Routes.EMAIL_VERIFICATION.path,
      page: () => const EmailValidatePage(),
    ),
    GetPage(
      name: Routes.HOME.path,
      page: () => const Scaffold(),
    ),
    GetPage(
      name: Routes.PRIVACY_POLICY.path,
      page: () => const PolicyPage(),
    ),
  ];
}
