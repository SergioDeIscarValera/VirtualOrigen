import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:virtual_origen_app/firebase_options.dart';
import 'package:virtual_origen_app/routes/app_pages.dart';
import 'package:virtual_origen_app/routes/app_routes.dart';
import 'package:virtual_origen_app/themes/thrmes.dart';
import 'package:virtual_origen_app/utils/localizations.dart';
import 'package:virtual_origen_app/utils/storage_keys.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    var userThemeConfig = box.read(StorageKeys.THEME_MODE.key);
    return GetMaterialApp(
      title: 'Virtual Origen App',
      debugShowCheckedModeBanner: false,
      theme: Themes.LIGHT.data,
      darkTheme: Themes.DARK.data,
      themeMode: userThemeConfig == null
          ? ThemeMode.system
          : userThemeConfig
              ? ThemeMode.dark
              : ThemeMode.light,

      // initialBinding: BindingsBuilder(() {
      //   Get.put<AuthController>(
      //     AuthController(),
      //     permanent: true,
      //   );
      // }),

      initialRoute: Routes.FIRST_TIME.path,
      getPages: AppPages.routes,

      // Para que funcione el scroll con el mouse (drag)
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
        },
      ),

      translations: MyLocalizations(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
    );
  }
}
