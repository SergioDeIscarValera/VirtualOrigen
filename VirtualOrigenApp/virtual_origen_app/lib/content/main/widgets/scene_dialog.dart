import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_origen_app/content/main/widgets/color_dropdown.dart';
import 'package:virtual_origen_app/content/main/widgets/smart_device_type_dropdown.dart';
import 'package:virtual_origen_app/models/scene.dart';
import 'package:virtual_origen_app/models/smart_device_type.dart';
import 'package:virtual_origen_app/themes/colors.dart';
import 'package:virtual_origen_app/themes/styles/my_text_styles.dart';
import 'package:virtual_origen_app/utils/form_validator.dart';
import 'package:virtual_origen_app/widgets/my_text_form.dart';
import 'package:virtual_origen_app/widgets/responsive_layout.dart';
import 'package:virtual_origen_app/widgets/rounded_button.dart';
import 'package:virtual_origen_app/widgets/wrap_in_mid.dart';

class SceneDialog extends StatelessWidget {
  const SceneDialog(
      {Key? key, this.scene, required this.onSave, required this.onDelete})
      : super(key: key);
  final Scene? scene;
  final Function(Scene) onSave;
  final Function(Scene) onDelete;
  @override
  Widget build(BuildContext context) {
    var validator = Get.find<FormValidator>();
    return ResponsiveLayout(
      mobile: Dialog.fullscreen(
        backgroundColor: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.all(10),
          child: SceneDialogBody(
            validator: validator,
            scene: scene,
            onSave: onSave,
            onDelete: onDelete,
          ),
        ),
      ),
      tablet: Dialog(
        child: SceneDialogBody(
          validator: validator,
          scene: scene,
          onSave: onSave,
          onDelete: onDelete,
        ),
      ),
      desktop: WrapInMid(
        child: Dialog(
          child: SceneDialogBody(
            validator: validator,
            scene: scene,
            onSave: onSave,
            onDelete: onDelete,
          ),
        ),
      ),
    );
  }
}

class SceneDialogBody extends StatelessWidget {
  const SceneDialogBody({
    Key? key,
    required this.validator,
    this.scene,
    required this.onSave,
    required this.onDelete,
  }) : super(key: key);
  final FormValidator validator;
  final Scene? scene;
  final Function(Scene) onSave;
  final Function(Scene) onDelete;
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var nameController = TextEditingController(text: scene?.name);
    final Rx<MyColors> color = scene != null
        ? scene!.color.obs
        : MyColors.values.firstWhere((e) => e.isSelectable).obs;
    final Rx<SmartDeviceType> smartDeviceType =
        scene != null ? scene!.type.obs : SmartDeviceType.OTHER.obs;

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
                scene != null ? "edit_scene_title".tr : "new_scene_title".tr,
                style: MyTextStyles.h2.textStyle.copyWith(
                  color: MyColors.CONTRARY.color,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // Name
              MyTextForm(
                controller: nameController,
                icon: Icons.title,
                label: "scene_name".tr,
                color: MyColors.CONTRARY,
                validator: (text) => validator.isValidText(text, 150),
              ),
              const SizedBox(height: 20),
              // Color
              Obx(
                () => WrapInMid(
                  child: ColorDropdown(
                    onChanged: (value) => color.value = value!,
                    value: color.value,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Smart Device Type
              Obx(
                () => WrapInMid(
                  child: SmartDeviceTypeDropdown(
                    onChanged: (value) => smartDeviceType.value = value!,
                    value: smartDeviceType.value,
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
                        var newScene = Scene(
                          id: scene?.id,
                          name: nameController.text,
                          color: color.value,
                          type: smartDeviceType.value,
                          devicesConfig: scene?.devicesConfig ?? [],
                        );
                        onSave(newScene);
                      }
                    },
                    color: MyColors.PRIMARY,
                    textColor: MyColors.LIGHT,
                    text: "save".tr,
                    icon: Icons.save,
                    isSmall: context.width < 550,
                  ),
                  if (scene != null)
                    RoundedButton(
                      onPressed: () => onDelete(scene!),
                      color: MyColors.DANGER,
                      textColor: MyColors.LIGHT,
                      text: "delete".tr,
                      icon: Icons.delete,
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
