import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:virtual_origen_app/content/main/storage/controller/property_controller.dart';
import 'package:virtual_origen_app/content/main/widgets/dotted_card.dart';
import 'package:virtual_origen_app/content/main/widgets/smart_device_card.dart';
import 'package:virtual_origen_app/content/main/widgets/user_header.dart';
import 'package:virtual_origen_app/models/property.dart';
import 'package:virtual_origen_app/services/auth/interface_auth_service.dart';
import 'package:virtual_origen_app/themes/colors.dart';
import 'package:virtual_origen_app/themes/styles/my_text_styles.dart';
import 'package:virtual_origen_app/widgets/my_scaffold.dart';

import '../widgets/dropdown_menu_more_info.dart';

class PropertyPage extends StatelessWidget {
  const PropertyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PropertyController>();
    var authService = Get.find<IAuthService>();
    var propertySelected = Get.arguments['property'] as Property?;
    controller.setPropertySelected(propertySelected);
    return MyScaffold(
      backgroundColor: MyColors.CURRENT,
      body: PropertyBody(
        authService: authService,
        controller: controller,
      ),
    );
  }
}

class PropertyBody extends StatelessWidget {
  const PropertyBody({
    Key? key,
    required this.controller,
    required this.authService,
  }) : super(key: key);

  final PropertyController controller;
  final IAuthService authService;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Center(
                child: DropdownMenuMoreInfo(
                  controller: controller,
                ),
              ),
              Obx(
                () => Container(
                  decoration: BoxDecoration(
                    color: controller.propertySelected.value.color.color,
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(24),
                    ),
                  ),
                  padding: const EdgeInsets.only(
                    top: 77,
                    bottom: 2,
                    left: 10,
                    right: 10,
                  ),
                  child: Center(
                    child: Text(
                      controller.propertySelected.value.name,
                      style: MyTextStyles.h1.textStyle.copyWith(
                        color: MyColors.LIGHT.color,
                      ),
                    ),
                  ),
                ).animate().fade().slide(),
              ),
              UserHeader(
                userName: authService.getName(),
                userImage: authService.getProfileImage(),
                haveNotification: true,
              ),
            ],
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(15),
              children: [
                Text(
                  "smart_devices".tr,
                  style: MyTextStyles.h3.textStyle,
                ),
                const SizedBox(height: 15),
                Obx(
                  () => Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 15,
                    children: controller.smartDevices
                        .map(
                          (smartDevice) => SmartDeviceCard(
                            smartDevice: smartDevice,
                            onTap: controller.navigateSmartDeviceDetails,
                            onLongPress: controller.editSmartDeviceDialog,
                            onSwitch: controller.changeManualMode,
                          ),
                        )
                        .toList(),
                  ),
                ),
                SizedBox(
                  height: 170,
                  child: DottedCard(
                    onTap: controller.newSmartDeviceDialog,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
