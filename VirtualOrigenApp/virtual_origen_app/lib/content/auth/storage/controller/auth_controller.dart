import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_origen_app/routes/app_routes.dart';
import 'package:virtual_origen_app/services/auth/interface_auth_service.dart';
import 'package:virtual_origen_app/services/storage/interface_local_storage.dart';
import 'package:virtual_origen_app/utils/my_snackbar.dart';
import 'package:virtual_origen_app/utils/storage_keys.dart';

class AuthController extends GetxController {
  late final ILocalStorage storage;
  late final IAuthService authService;
  late final MySnackbar snackbar;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void onReady() {
    storage = Get.find<ILocalStorage>();
    authService = Get.find<IAuthService>();
    snackbar = Get.find<MySnackbar>();
    authService.authChanges(_authEventHandle);
    super.onReady();
  }

  @override
  onClose() {
    authService.removeAuthChanges();
    super.onClose();
  }

  _authEventHandle(User? newUser) {
    var currentPath =
        Routes.values.firstWhere((element) => element.path == Get.currentRoute);
    if (currentPath == Routes.PRIVACY_POLICY) return;
    var isFirstTime = storage.getData<bool?>(
      StorageKeys.IS_FIRST_TIME.key,
      defaultValue: false,
    );
    if (isFirstTime == null || isFirstTime) {
      storage.saveData(StorageKeys.IS_FIRST_TIME.key, false);
      Get.offAllNamed(Routes.FIRST_TIME.path);
      return;
    }
    if (newUser == null) {
      Get.offAllNamed(Routes.LOGIN.path);
      return;
    }
    if (!newUser.emailVerified) {
      Get.offAllNamed(Routes.EMAIL_VERIFICATION.path);
      return;
    }
    Get.offAllNamed(Routes.HOME.path);
  }

  void loginGoogle() {
    authService.loginWithGoogle(
      onSuccess: () {
        snackbar.snackSuccess('login_with_google_success'.tr);
      },
      onError: (error) {
        snackbar.snackError(error);
      },
    );
  }

  void loginEmail() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      return;
    }
    authService.login(
      emailController.text,
      passwordController.text,
      onSuccess: () {
        snackbar.snackSuccess('login_with_email_success'.tr);
      },
      onError: (error) {
        snackbar.snackError(error);
      },
    );
  }

  void toRegister() {
    Get.toNamed(Routes.SINGUP.path);
  }

  void singupEmail() {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      return;
    }
    if (passwordController.text != confirmPasswordController.text) {
      return;
    }
    authService.singUp(
      emailController.text,
      passwordController.text,
      onSuccess: () {
        snackbar.snackSuccess('singup_with_email_success'.tr);
      },
      onError: (error) {
        snackbar.snackError(error);
      },
    );
  }

  void toLogin() {
    Get.toNamed(Routes.LOGIN.path);
  }

  void startEmailValidation() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      checkEmailVerificationStatus(timer: timer);
    });
  }

  void manualyCheckEmailVerificationStatus() {
    checkEmailVerificationStatus();
  }

  void checkEmailVerificationStatus({Timer? timer}) {
    if (authService.isEmailVerified() == true) {
      timer?.cancel();
      snackbar.snackSuccess("email_verified".tr);
      Get.offAllNamed(Routes.HOME.path);
    }
  }

  sendEmailVerification() {
    authService.sendEmailVerification(
      onSuccess: () {
        snackbar.snackSuccess("email_verified_sent".tr);
      },
      onError: (error) {
        snackbar.snackError(error);
      },
    );
  }

  void toForgotPassword() {
    Get.toNamed(Routes.FORGOT_PASSWORD.path);
  }

  void sendEmailPassword() {
    authService.sendForgotPassword(
      email: emailController.text,
      onSuccess: () {
        snackbar.snackSuccess("email_recovery_sent".tr);
        Get.offAllNamed(Routes.LOGIN.path);
      },
      onError: (error) {
        snackbar.snackError(error);
      },
    );
  }
}
