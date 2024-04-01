import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_origen_app/content/main/storage/controller/user_controller.dart';
import 'package:virtual_origen_app/content/main/widgets/user_header.dart';
import 'package:virtual_origen_app/services/auth/interface_auth_service.dart';
import 'package:virtual_origen_app/themes/colors.dart';
import 'package:virtual_origen_app/themes/styles/my_text_styles.dart';
import 'package:virtual_origen_app/widgets/my_scaffold.dart';
import 'package:virtual_origen_app/widgets/my_text_form.dart';

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
    final nameController = TextEditingController(text: authService.getName());
    return Expanded(
      child: Column(
        children: [
          UserHeader(
            userName: authService.getName(),
            userImage: authService.getProfileImage(),
            haveProfile: false,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(15),
              children: [
                Text(
                  "user_data".tr,
                  style: MyTextStyles.h3.textStyle,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.network(
                    width: 200,
                    height: 200,
                    authService.getProfileImage(),
                    loadingBuilder: (context, child, loadingProgress) =>
                        loadingProgress == null
                            ? child
                            : const CircularProgressIndicator(),
                  ),
                ),
                const SizedBox(height: 15),
                MyTextForm(
                  controller: nameController,
                  icon: Icons.person,
                  label: "",
                  color: MyColors.PRIMARY,
                  editable: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
