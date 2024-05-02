import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_origen_app/content/main/widgets/dotted_card.dart';
import 'package:virtual_origen_app/models/scene.dart';
import 'package:virtual_origen_app/models/smart_device.dart';
import 'package:virtual_origen_app/models/smart_device_type.dart';
import 'package:virtual_origen_app/themes/colors.dart';
import 'package:virtual_origen_app/themes/styles/my_text_styles.dart';
import 'package:virtual_origen_app/widgets/rounded_button.dart';

class SceneCard extends StatelessWidget {
  const SceneCard({
    Key? key,
    required this.scene,
    required this.onLongPress,
    required this.onTapDevice,
    required this.onTapNewDevice,
    required this.applyScene,
  }) : super(key: key);
  final Scene scene;
  final Function(Scene) onLongPress;
  final Function(Scene, SmartDevice) onTapDevice;
  final Function(Scene) onTapNewDevice;
  final Function(Scene) applyScene;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onLongPress: () => onLongPress(scene),
        child: Container(
          decoration: BoxDecoration(
            color: scene.color.color,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.only(bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(
                    scene.type.icon,
                    color: MyColors.LIGHT.color,
                    size: 35,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      scene.name,
                      style: MyTextStyles.h3.textStyle.copyWith(
                        color: MyColors.LIGHT.color,
                        fontSize: 24,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const SizedBox(width: 10),
                  RoundedButton(
                    onPressed: () => applyScene(scene),
                    color: MyColors.SUCCESS,
                    textColor: MyColors.LIGHT,
                    tooltip: "apply".tr,
                    icon: Icons.send,
                    isSmall: true,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  ...scene.devicesConfig
                      .map(
                        (e) => GestureDetector(
                          onTap: () => onTapDevice(scene, e),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: MyColors.LIGHT.color,
                                width: 4,
                              ),
                              color: e.color.color,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Icon(
                                  e.type.icon,
                                  color: MyColors.LIGHT.color,
                                  size: 35,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  e.name,
                                  style: MyTextStyles.p.textStyle.copyWith(
                                    color: MyColors.LIGHT.color,
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  Tooltip(
                    message: "add_scene_device".tr,
                    child: SizedBox(
                      height: 105,
                      width: 80,
                      child: DottedCard(
                        onTap: () => onTapNewDevice(scene),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
