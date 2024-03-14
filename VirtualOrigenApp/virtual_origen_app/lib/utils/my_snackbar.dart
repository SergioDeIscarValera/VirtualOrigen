import 'package:get/get.dart';
import 'package:virtual_origen_app/themes/colors.dart';

class MySnackbar {
  void snackError(String message) {
    Get.snackbar(
      "Error",
      message.tr,
      backgroundColor: MyColors.DANGER.color.withOpacity(0.5),
      colorText: MyColors.LIGHT.color,
    );
  }

  void snackSuccess(String message) {
    Get.snackbar(
      "Success",
      message.tr,
      backgroundColor: MyColors.SUCCESS.color.withOpacity(0.5),
      colorText: MyColors.LIGHT.color,
    );
  }

  void snackWarning(String message) {
    Get.snackbar(
      "Warning",
      message.tr,
      backgroundColor: MyColors.WARNING.color.withOpacity(0.5),
      colorText: MyColors.LIGHT.color,
    );
  }
}
