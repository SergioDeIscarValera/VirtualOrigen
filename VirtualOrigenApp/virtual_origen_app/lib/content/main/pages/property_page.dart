import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:virtual_origen_app/content/main/storage/controller/property_controller.dart';
import 'package:virtual_origen_app/content/main/widgets/dotted_card.dart';
import 'package:virtual_origen_app/content/main/widgets/scene_card.dart';
import 'package:virtual_origen_app/content/main/widgets/smart_device_card.dart';
import 'package:virtual_origen_app/content/main/widgets/user_header.dart';
import 'package:virtual_origen_app/models/invitation_permission.dart';
import 'package:virtual_origen_app/models/property.dart';
import 'package:virtual_origen_app/services/auth/interface_auth_service.dart';
import 'package:virtual_origen_app/themes/colors.dart';
import 'package:virtual_origen_app/themes/styles/my_text_styles.dart';
import 'package:virtual_origen_app/widgets/my_scaffold.dart';
import 'package:virtual_origen_app/widgets/responsive_layout.dart';
import 'package:virtual_origen_app/content/main/widgets/dropdown_menu_more_info.dart';
import 'package:virtual_origen_app/content/main/widgets/property_guest_card.dart';

class PropertyPage extends StatelessWidget {
  const PropertyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PropertyController>();
    var authService = Get.find<IAuthService>();
    final args = Get.arguments as Map<String, dynamic>?;
    if (args == null) {
      Get.back();
      return const SizedBox();
    }
    var propertySelected = args.containsKey('property')
        ? Get.arguments['property'] as Property
        : null;
    var ownerUid = args.containsKey('ownerUid')
        ? Get.arguments['ownerUid'] as String
        : null;
    controller.setPropertySelected(propertySelected, ownerUid);
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
                authService: authService,
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
                Obx(() {
                  final permission = controller.propertySelected.value
                      .getPermission(authService.getEmail());
                  return Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 15,
                    children: [
                      ...controller.smartDevices
                          .map(
                            (smartDevice) => SmartDeviceCard(
                              smartDevice: smartDevice,
                              onTap: controller.navigateSmartDeviceDetails,
                              onLongPress: (value) {
                                if (permission == InvitationPermission.READ) {
                                  return;
                                }
                                controller.editSmartDeviceDialog(smartDevice);
                              },
                              onSwitch: controller.changeManualMode,
                              switchIsReadOnly:
                                  permission == InvitationPermission.READ,
                            ),
                          )
                          .toList(),
                      if (controller.propertySelected.value
                              .getPermission(authService.getEmail()) !=
                          InvitationPermission.READ)
                        Tooltip(
                          message: "add_smart_device".tr,
                          child: SizedBox(
                            height: 170,
                            child: DottedCard(
                              onTap: controller.newSmartDeviceDialog,
                            ),
                          ),
                        ),
                    ]
                        .map((e) => ResponsiveLayout(
                              mobile: e,
                              tablet: SizedBox(
                                width: context.width * 0.455,
                                child: e,
                              ),
                              desktop: SizedBox(
                                width: context.width * 0.3,
                                child: e,
                              ),
                            ))
                        .toList(),
                  );
                }),
                const SizedBox(height: 30),
                Obx(() {
                  if (controller.propertySelected.value
                              .getPermission(authService.getEmail()) !=
                          InvitationPermission.FULL &&
                      controller.ownerUid != authService.getUid()) {
                    return const SizedBox();
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "guest_title".tr,
                        style: MyTextStyles.h3.textStyle,
                      ),
                      const SizedBox(height: 15),
                      Center(
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 15,
                          children: [
                            ...controller.propertySelected.value.guests
                                .map((propertyGuest) => PropertyGuestCard(
                                      propertyGuest: propertyGuest,
                                      onPermissionChange:
                                          controller.changeGuestPermission,
                                      onRemove: controller.removeGuest,
                                    )),
                            Tooltip(
                              message: "add_guest".tr,
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: controller.openInvitationDialog,
                                  child: SizedBox(
                                    height: 70,
                                    width: 70,
                                    child: DottedBorder(
                                      color: MyColors.CONTRARY.color,
                                      radius: const Radius.circular(75),
                                      borderType: BorderType.RRect,
                                      dashPattern: const [8, 4],
                                      strokeWidth: 2,
                                      child: Center(
                                        child: Icon(
                                          Icons.add,
                                          color: MyColors.CONTRARY.color,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        "scene_title".tr,
                        style: MyTextStyles.h3.textStyle,
                      ),
                      const SizedBox(height: 15),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 15,
                        children: [
                          ...controller.scenes.map(
                            (scene) => SceneCard(
                              scene: scene,
                              onLongPress: (value) =>
                                  controller.openSceneDialog(scene: value),
                              onTapDevice: (value, value2) =>
                                  controller.editSceneDeviceDialog(
                                scene: value,
                                smartDevice: value2,
                              ),
                              onTapNewDevice: (value) =>
                                  controller.openSceneDeviceDialog(
                                scene: value,
                              ),
                              applyScene: (value) => controller.applyScene(
                                scene: value,
                              ),
                            ),
                          ),
                          Tooltip(
                            message: "add_scene".tr,
                            child: SizedBox(
                              height: 170,
                              child: DottedCard(
                                onTap: controller.openSceneDialog,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                    ],
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
