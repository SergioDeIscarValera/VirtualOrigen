import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_origen_app/content/main/storage/controller/user_controller.dart';
import 'package:virtual_origen_app/themes/colors.dart';
import 'package:virtual_origen_app/widgets/my_scaffold.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<UserController>();
    return MyScaffold(
      backgroundColor: MyColors.CURRENT,
      body: UserBody(controller: controller),
    );
  }
}

class UserBody extends StatelessWidget {
  const UserBody({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final UserController controller;

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
        ],
      ),
    );
  }
}
