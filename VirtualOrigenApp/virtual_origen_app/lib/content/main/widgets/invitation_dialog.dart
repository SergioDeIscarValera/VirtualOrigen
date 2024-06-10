import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_origen_app/models/invitation_permission.dart';
import 'package:virtual_origen_app/themes/colors.dart';
import 'package:virtual_origen_app/themes/styles/my_text_styles.dart';
import 'package:virtual_origen_app/utils/form_validator.dart';
import 'package:virtual_origen_app/widgets/my_text_form.dart';
import 'package:virtual_origen_app/widgets/responsive_layout.dart';
import 'package:virtual_origen_app/widgets/rounded_button.dart';
import 'package:virtual_origen_app/widgets/wrap_in_mid.dart';

import 'invitation_permission_dropdown.dart';

class InvitationDialog extends StatelessWidget {
  const InvitationDialog({
    Key? key,
    required this.onSendInvitation,
  }) : super(key: key);

  final Function(String, InvitationPermission) onSendInvitation;

  @override
  Widget build(BuildContext context) {
    var validator = Get.find<FormValidator>();
    return ResponsiveLayout(
      mobile: Dialog.fullscreen(
        backgroundColor: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Center(
            child: InvitationDialogBody(
              onSendInvitation: onSendInvitation,
              validator: validator,
            ),
          ),
        ),
      ),
      tablet: Dialog(
        child: InvitationDialogBody(
          onSendInvitation: onSendInvitation,
          validator: validator,
        ),
      ),
      desktop: WrapInMid(
        child: Dialog(
          child: InvitationDialogBody(
            onSendInvitation: onSendInvitation,
            validator: validator,
          ),
        ),
      ),
    );
  }
}

class InvitationDialogBody extends StatelessWidget {
  const InvitationDialogBody({
    Key? key,
    required this.onSendInvitation,
    required this.validator,
  }) : super(key: key);

  final Function(String, InvitationPermission) onSendInvitation;
  final FormValidator validator;

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    Rx<InvitationPermission> permissionType = InvitationPermission.READ.obs;
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: MyColors.CURRENT.color,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "send_invitation_title".tr,
                style: MyTextStyles.h2.textStyle.copyWith(
                  color: MyColors.CONTRARY.color,
                ),
              ),
              const SizedBox(height: 20),
              // Email
              MyTextForm(
                controller: emailController,
                icon: Icons.title,
                label: "guest_email".tr,
                color: MyColors.CONTRARY,
                validator: validator.isValidEmail,
              ),
              const SizedBox(height: 20),
              // Permission
              Obx(
                () => WrapInMid(
                  child: InvitationPermissionDropdown(
                    onChanged: (value) => permissionType.value = value!,
                    value: permissionType.value,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RoundedButton(
                    onPressed: () {
                      Get.back();
                    },
                    color: MyColors.WARNING,
                    textColor: MyColors.LIGHT,
                    text: "cancel".tr,
                    icon: Icons.cancel,
                    isSmall: context.width < 550,
                  ),
                  RoundedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        onSendInvitation(
                          emailController.text,
                          permissionType.value,
                        );
                      }
                    },
                    color: MyColors.PRIMARY,
                    textColor: MyColors.LIGHT,
                    text: "send".tr,
                    icon: Icons.send,
                    isSmall: context.width < 550,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
