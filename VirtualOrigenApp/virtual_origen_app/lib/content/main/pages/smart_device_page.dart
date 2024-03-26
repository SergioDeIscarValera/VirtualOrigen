import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:virtual_origen_app/content/main/storage/controller/smart_device_controller.dart';
import 'package:virtual_origen_app/themes/colors.dart';
import 'package:virtual_origen_app/widgets/my_scaffold.dart';
import 'package:virtual_origen_app/widgets/responsive_layout.dart';
import 'package:virtual_origen_app/widgets/wrap_in_mid.dart';

class SmartDevicePage extends StatelessWidget {
  const SmartDevicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<SmartDeviceController>();
    return MyScaffold(
      backgroundColor: MyColors.PRIMARY,
      body: ResponsiveLayout(
        mobile: SmartDeviceBody(controller: controller),
        tablet: SmartDeviceBody(controller: controller),
        desktop: WrapInMid(
          child: SmartDeviceBody(controller: controller),
        ),
      ),
    );
  }
}

class SmartDeviceBody extends StatelessWidget {
  const SmartDeviceBody({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SmartDeviceController controller;

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
