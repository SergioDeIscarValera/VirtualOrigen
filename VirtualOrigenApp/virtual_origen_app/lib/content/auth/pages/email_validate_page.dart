import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_origen_app/content/auth/storage/controller/auth_controller.dart';
import 'package:virtual_origen_app/themes/colors.dart';
import 'package:virtual_origen_app/themes/styles/my_text_styles.dart';
import 'package:virtual_origen_app/widgets/my_scaffold.dart';
import 'package:virtual_origen_app/widgets/responsive_layout.dart';
import 'package:virtual_origen_app/widgets/rounded_button.dart';
import 'package:virtual_origen_app/widgets/wrap_in_mid.dart';

class EmailValidatePage extends StatelessWidget {
  const EmailValidatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authController = Get.find<AuthController>();
    authController.startEmailValidation();
    return MyScaffold(
      backgroundColor: MyColors.PRIMARY,
      body: ResponsiveLayout(
        mobile: EmailValidateBody(
          authController: authController,
        ),
        tablet: EmailValidateBody(
          authController: authController,
        ),
        desktop: WrapInMid(
          child: EmailValidateBody(
            authController: authController,
          ),
        ),
      ),
    );
  }
}

class EmailValidateBody extends StatelessWidget {
  const EmailValidateBody({
    Key? key,
    required this.authController,
  }) : super(key: key);
  final AuthController authController;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.CURRENT.color,
      ),
      child: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          const SizedBox(height: 25),
          const Image(image: AssetImage("assets/images/logo.png"), height: 150),
          const SizedBox(height: 25),
          Text(
            "title_email_validate".tr,
            style: MyTextStyles.h1.textStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 25),
          Text(
            "email_validate".tr,
            style: MyTextStyles.p.textStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          RoundedButton(
            onPressed: authController.checkEmailVerificationStatus,
            text: "check_email".tr,
            color: MyColors.SUCCESS,
            textColor: MyColors.LIGHT,
          ),
          const SizedBox(height: 25),
          RoundedButton(
            onPressed: authController.sendEmailVerification,
            text: "resend_email".tr,
            color: MyColors.WARNING,
            textColor: MyColors.LIGHT,
          ),
        ],
      ),
    );
  }
}
