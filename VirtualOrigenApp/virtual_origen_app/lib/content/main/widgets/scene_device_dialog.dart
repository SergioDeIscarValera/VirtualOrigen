import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_origen_app/models/scene.dart';
import 'package:virtual_origen_app/models/smart_device.dart';
import 'package:virtual_origen_app/models/smart_device_type.dart';
import 'package:virtual_origen_app/themes/colors.dart';
import 'package:virtual_origen_app/themes/styles/my_text_styles.dart';
import 'package:virtual_origen_app/widgets/responsive_layout.dart';
import 'package:virtual_origen_app/widgets/rounded_button.dart';
import 'package:virtual_origen_app/widgets/wrap_in_mid.dart';

class SceneDeviceDialog extends StatelessWidget {
  const SceneDeviceDialog({
    Key? key,
    required this.scene,
    required this.smartDevices,
    required this.onSave,
  }) : super(key: key);

  final Scene scene;
  final List<SmartDevice> smartDevices;
  final Function(SmartDevice) onSave;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: Dialog.fullscreen(
        backgroundColor: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.all(10),
          child: SceneDialogBody(
            scene: scene,
            smartDevices: smartDevices,
            onSave: onSave,
          ),
        ),
      ),
      tablet: Dialog(
        child: SceneDialogBody(
          scene: scene,
          smartDevices: smartDevices,
          onSave: onSave,
        ),
      ),
      desktop: WrapInMid(
        child: Dialog(
          child: SceneDialogBody(
            scene: scene,
            smartDevices: smartDevices,
            onSave: onSave,
          ),
        ),
      ),
    );
  }
}

class SceneDialogBody extends StatelessWidget {
  const SceneDialogBody({
    Key? key,
    required this.scene,
    required this.smartDevices,
    required this.onSave,
  }) : super(key: key);

  final Scene scene;
  final List<SmartDevice> smartDevices;
  final Function(SmartDevice) onSave;
  @override
  Widget build(BuildContext context) {
    final Rx<SmartDevice> smartDeviceSelected = smartDevices.first.obs;

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: MyColors.CURRENT.color,
        borderRadius: BorderRadius.circular(24),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "add_scene_device".tr,
              style: MyTextStyles.h2.textStyle.copyWith(
                color: MyColors.CONTRARY.color,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Obx(
              () => DropdownButton(
                items: smartDevices
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        alignment: Alignment.center,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: e.color.color,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  e.type.icon,
                                  color: MyColors.LIGHT.color,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  e.name,
                                  style: MyTextStyles.p.textStyle.copyWith(
                                    color: MyColors.LIGHT.color,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  smartDeviceSelected.value = value!;
                },
                value: smartDeviceSelected.value,
                isExpanded: true,
                borderRadius: BorderRadius.circular(12),
                underline: const SizedBox(),
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
                    onSave(smartDeviceSelected.value);
                  },
                  color: MyColors.PRIMARY,
                  textColor: MyColors.LIGHT,
                  text: "save".tr,
                  icon: Icons.save,
                  isSmall: context.width < 550,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
