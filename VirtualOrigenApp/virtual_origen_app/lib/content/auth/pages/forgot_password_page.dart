import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_origen_app/content/auth/storage/controller/auth_controller.dart';
import 'package:virtual_origen_app/content/auth/widgets/external_login_privider_button.dart';
import 'package:virtual_origen_app/themes/colors.dart';
import 'package:virtual_origen_app/themes/styles/my_text_styles.dart';
import 'package:virtual_origen_app/utils/form_validator.dart';
import 'package:virtual_origen_app/widgets/my_scaffold.dart';
import 'package:virtual_origen_app/widgets/my_split.dart';
import 'package:virtual_origen_app/widgets/my_text_form.dart';
import 'package:virtual_origen_app/widgets/responsive_layout.dart';
import 'package:virtual_origen_app/widgets/rounded_button.dart';
import 'package:virtual_origen_app/widgets/wrap_in_mid.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authController = Get.find<AuthController>();
    var validator = Get.find<FormValidator>();
    return MyScaffold(
      backgroundColor: MyColors.PRIMARY,
      body: ResponsiveLayout(
        mobile: ForgotPasswordBody(
          authController: authController,
          validator: validator,
        ),
        tablet: ForgotPasswordBody(
          authController: authController,
          validator: validator,
        ),
        desktop: WrapInMid(
          child: ForgotPasswordBody(
            authController: authController,
            validator: validator,
          ),
        ),
      ),
    );
  }
}

class ForgotPasswordBody extends StatelessWidget {
  const ForgotPasswordBody({
    Key? key,
    required this.authController,
    required this.validator,
  }) : super(key: key);
  final AuthController authController;
  final FormValidator validator;
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
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
            "title_forgot_password".tr,
            style: MyTextStyles.h1.textStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          Form(
            key: formKey,
            child: Column(
              children: [
                MyTextForm(
                  label: "email".tr,
                  controller: authController.emailController,
                  color: MyColors.CONTRARY,
                  icon: Icons.email,
                  validator: validator.isValidName,
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          RoundedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                authController.sendEmailPassword();
              }
            },
            color: MyColors.WARNING,
            textColor: MyColors.LIGHT,
            text: "send_email_password".tr,
          ),
          const SizedBox(height: 50),
          const MySplit(),
          const SizedBox(height: 50),
          ExternalLoginPrividerButton(
            onPressed: authController.loginGoogle,
            image: "assets/images/google.png",
            text: "login_with_google".tr,
          ),
          const SizedBox(height: 50),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            children: [
              Text(
                "no_account".tr,
                style: MyTextStyles.p.textStyle,
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: authController.toRegister,
                  child: Text(
                    "singup_button".tr,
                    style: MyTextStyles.link.textStyle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
