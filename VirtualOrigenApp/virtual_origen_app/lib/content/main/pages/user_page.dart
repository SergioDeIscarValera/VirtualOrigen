import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_origen_app/content/main/storage/controller/user_controller.dart';
import 'package:virtual_origen_app/content/main/widgets/user_header.dart';
import 'package:virtual_origen_app/services/auth/interface_auth_service.dart';
import 'package:virtual_origen_app/themes/colors.dart';
import 'package:virtual_origen_app/themes/styles/my_text_styles.dart';
import 'package:virtual_origen_app/widgets/my_scaffold.dart';
import 'package:virtual_origen_app/widgets/my_text_form.dart';
import 'package:virtual_origen_app/widgets/rounded_button.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<UserController>();
    var authService = Get.find<IAuthService>();
    return MyScaffold(
      backgroundColor: MyColors.CURRENT,
      body: UserBody(
        controller: controller,
        authService: authService,
      ),
    );
  }
}

class UserBody extends StatelessWidget {
  const UserBody({
    Key? key,
    required this.controller,
    required this.authService,
  }) : super(key: key);

  final UserController controller;
  final IAuthService authService;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          UserHeader(
            authService: authService,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Text(
                    "user_data".tr,
                    style: MyTextStyles.h3.textStyle,
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      controller.pickImage();
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Obx(
                        () {
                          if (controller.profileImage.value
                                  .startsWith("http") ||
                              GetPlatform.isWeb) {
                            return Image.network(
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                              controller.profileImage.value,
                              loadingBuilder:
                                  (context, child, loadingProgress) =>
                                      loadingProgress == null
                                          ? child
                                          : const CircularProgressIndicator(),
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(
                                Icons.error_outline_rounded,
                                color: MyColors.CONTRARY.color,
                                size: 150,
                              ),
                            );
                          } else {
                            return Image.file(
                              File(controller.profileImage.value),
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  MyTextForm(
                    controller: controller.nameController,
                    icon: Icons.person,
                    label: "user_name".tr,
                    color: MyColors.PRIMARY,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RoundedButton(
                        onPressed: () {
                          controller.reset();
                        },
                        color: MyColors.WARNING,
                        textColor: MyColors.LIGHT,
                        text: "cancel".tr,
                        icon: Icons.refresh,
                        isSmall: context.width < 550,
                      ),
                      RoundedButton(
                        onPressed: () {
                          controller.saveUserData();
                        },
                        color: MyColors.PRIMARY,
                        textColor: MyColors.LIGHT,
                        text: "save".tr,
                        icon: Icons.save,
                        isSmall: context.width < 550,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Obx(
                    () => ExpansionTile(
                      title: Text(
                        "new_invitations".tr,
                        style: MyTextStyles.p.textStyle,
                        textAlign: TextAlign.center,
                      ),
                      leading: Icon(
                        Icons.notifications_active,
                        color: MyColors.SUCCESS.color,
                      ),
                      expandedAlignment: Alignment.center,
                      onExpansionChanged: (value) {
                        if (value) {
                          controller.mackAsReaded();
                        }
                      },
                      children: controller.newInvitations
                          .map(
                            (invitation) => ListTile(
                              title: Text(
                                invitation.propertyName,
                                style: MyTextStyles.p.textStyle.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                invitation.fromEmail,
                                style: MyTextStyles.p.textStyle.copyWith(
                                  color:
                                      MyColors.CONTRARY.color.withOpacity(0.4),
                                ),
                              ),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  invitation.fromProfileImage,
                                  width: 50,
                                  height: 50,
                                  loadingBuilder: (context, child,
                                          loadingProgress) =>
                                      loadingProgress == null
                                          ? child
                                          : const CircularProgressIndicator(),
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(
                                    Icons.error_outline_rounded,
                                    color: MyColors.CONTRARY.color,
                                    size: 50,
                                  ),
                                ),
                              ),
                              trailing: Wrap(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      color: MyColors.DANGER.color,
                                    ),
                                    onPressed: () {
                                      controller.processInvitation(
                                        invitation,
                                        false,
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.check,
                                      color: MyColors.SUCCESS.color,
                                    ),
                                    onPressed: () {
                                      controller.processInvitation(
                                        invitation,
                                        true,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Obx(
                    () => ExpansionTile(
                      title: Text(
                        "invitations".tr,
                        style: MyTextStyles.p.textStyle,
                        textAlign: TextAlign.center,
                      ),
                      leading: Icon(
                        Icons.house,
                        color: MyColors.SUCCESS.color,
                      ),
                      expandedAlignment: Alignment.center,
                      children: controller.oldInvitations
                          .map(
                            (invitation) => ListTile(
                              title: Text(
                                invitation.propertyName,
                                style: MyTextStyles.p.textStyle.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                invitation.fromEmail,
                                style: MyTextStyles.p.textStyle.copyWith(
                                  color:
                                      MyColors.CONTRARY.color.withOpacity(0.4),
                                ),
                              ),
                              trailing: Wrap(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: MyColors.DANGER.color,
                                    ),
                                    onPressed: () {
                                      controller.removeInvitation(
                                        invitation,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
