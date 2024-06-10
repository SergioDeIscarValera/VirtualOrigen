import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:virtual_origen_app/content/auth/storage/controller/auth_controller.dart';
import 'package:virtual_origen_app/firebase_options.dart';
import 'package:virtual_origen_app/routes/app_pages.dart';
import 'package:virtual_origen_app/routes/app_routes.dart';
import 'package:virtual_origen_app/services/auth/auth_service_firebase.dart';
import 'package:virtual_origen_app/services/auth/interface_auth_service.dart';
import 'package:virtual_origen_app/services/localities/interface_locaties.dart';
import 'package:virtual_origen_app/services/localities/locaties_google_maps.dart';
import 'package:virtual_origen_app/services/secrets.dart';
import 'package:virtual_origen_app/services/storage/interface_local_storage.dart';
import 'package:virtual_origen_app/services/storage/local_storage_get.dart';
import 'package:virtual_origen_app/themes/thrmes.dart';
import 'package:virtual_origen_app/utils/form_validator.dart';
import 'package:virtual_origen_app/utils/localizations.dart';
import 'package:virtual_origen_app/utils/my_snackbar.dart';
import 'package:virtual_origen_app/utils/storage_keys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (!GetPlatform.isWeb) {
    await GetStorage.init();
  }
  Get.put<ILocalStorage>(LocalStorageGet());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final localStorage = Get.find<ILocalStorage>();
    var userThemeConfig =
        localStorage.getData<bool>(StorageKeys.THEME_MODE.key);
    var userLanguage = localStorage.getData<String>(StorageKeys.LANGUAGE.key);
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

      initialBinding: BindingsBuilder(() {
        Get.put<AuthController>(
          AuthController(),
          permanent: true,
        );
        Get.put<IAuthService>(
          AuthServiceFirebase(),
          permanent: true,
        );
        Get.put(FormValidator(), permanent: true);
        Get.put(MySnackbar(), permanent: true);

        Get.put(Secrets(), permanent: true);
        Get.put<ILocaties>(LocatiesGoogleMaps(), permanent: true);
      }),

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
      //locale: Get.deviceLocale,
      locale: userLanguage == null ? Get.deviceLocale : Locale(userLanguage),
      fallbackLocale: const Locale('en', 'US'),
    );
  }
}
