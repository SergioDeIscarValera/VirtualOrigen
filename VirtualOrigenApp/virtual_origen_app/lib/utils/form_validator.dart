import 'package:get/get.dart';

class FormValidator extends GetxService {
  String? isValidName(String? text) {
    if (text == null || text.isEmpty || text.length < 3 || text.length > 75) {
      return "name_error".tr;
    }
    return null;
  }

  String? isValidEmail(String? text) {
    return (text ?? "").isEmail ? null : "email_error".tr;
  }

  String? isValidPass(String? text) {
    if (text == null || text.length < 6) {
      return "pass_error".tr;
    }
    return null;
  }

  String? isValidConfirmPass(String? text, String? pass) {
    if (text == null || text != pass) {
      return "confirm_pass_error".tr;
    }
    return null;
  }

  String? isValidText(String? text, int length) {
    if (text == null || text.isEmpty || text.length > length) {
      return "text_error".tr;
    }
    return null;
  }
}
