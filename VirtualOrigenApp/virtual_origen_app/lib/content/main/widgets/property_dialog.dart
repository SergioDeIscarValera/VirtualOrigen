import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:virtual_origen_app/models/pair.dart';
import 'package:virtual_origen_app/themes/colors.dart';
import 'package:virtual_origen_app/themes/styles/my_text_styles.dart';
import 'package:virtual_origen_app/utils/form_validator.dart';
import 'package:virtual_origen_app/widgets/my_text_form.dart';
import 'package:virtual_origen_app/widgets/responsive_layout.dart';
import 'package:virtual_origen_app/widgets/rounded_button.dart';
import 'package:virtual_origen_app/widgets/wrap_in_mid.dart';

import 'color_dropdown.dart';

class PropertyDialog extends StatelessWidget {
  const PropertyDialog({
    Key? key,
    required this.nameController,
    required this.color,
    required this.onChangedColor,
    required this.onSelectLocation,
    required this.selectedLocation,
    required this.onSave,
    this.onDelete,
    this.isEditing = false,
  }) : super(key: key);
  final TextEditingController nameController;
  final Rx<MyColors> color;
  final Function(MyColors?) onChangedColor;
  final Function(Pair<double, double>) onSelectLocation;
  final Pair<double, double> selectedLocation;
  final Function() onSave;
  final Function()? onDelete;
  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    var validator = Get.find<FormValidator>();
    return ResponsiveLayout(
      mobile: Material(
        type: MaterialType.transparency,
        child: Container(
          margin: const EdgeInsets.all(10),
          child: PropertyDialogBody(
            nameController: nameController,
            color: color,
            onChangedColor: onChangedColor,
            onSelectLocation: onSelectLocation,
            selectedLocation: selectedLocation,
            validator: validator,
            onSave: onSave,
            isEditing: isEditing,
            onDelete: onDelete,
          ),
        ),
      ),
      tablet: Dialog(
        child: PropertyDialogBody(
          nameController: nameController,
          color: color,
          onChangedColor: onChangedColor,
          onSelectLocation: onSelectLocation,
          selectedLocation: selectedLocation,
          validator: validator,
          onSave: onSave,
          isEditing: isEditing,
          onDelete: onDelete,
        ),
      ),
      desktop: Dialog(
        child: WrapInMid(
          child: PropertyDialogBody(
            nameController: nameController,
            color: color,
            onChangedColor: onChangedColor,
            onSelectLocation: onSelectLocation,
            selectedLocation: selectedLocation,
            validator: validator,
            onSave: onSave,
            isEditing: isEditing,
            onDelete: onDelete,
          ),
        ),
      ),
    );
  }
}

class PropertyDialogBody extends StatelessWidget {
  const PropertyDialogBody({
    Key? key,
    required this.nameController,
    required this.color,
    required this.onChangedColor,
    required this.onSelectLocation,
    required this.selectedLocation,
    required this.validator,
    required this.onSave,
    required this.isEditing,
    required this.onDelete,
  }) : super(key: key);
  final TextEditingController nameController;
  final Rx<MyColors> color;
  final Function(MyColors?) onChangedColor;
  final Function(Pair<double, double>) onSelectLocation;
  final Pair<double, double> selectedLocation;
  final FormValidator validator;
  final Function() onSave;
  final bool isEditing;
  final Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: MyColors.CURRENT.color,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Text(
              isEditing ? "edit_property".tr : "new_property".tr,
              style: MyTextStyles.h2.textStyle.copyWith(
                color: MyColors.CONTRARY.color,
              ),
            ),
            const SizedBox(height: 20),
            MyTextForm(
              controller: nameController,
              icon: Icons.title,
              label: "property_name".tr,
              color: MyColors.CONTRARY,
              validator: (text) => validator.isValidText(text, 150),
            ),
            const SizedBox(height: 20),
            Obx(
              () => WrapInMid(
                child: ColorDropdown(
                  onChanged: onChangedColor,
                  value: color.value,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target:
                        LatLng(selectedLocation.key, selectedLocation.value),
                    zoom: 15,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId('m1'),
                      position:
                          LatLng(selectedLocation.key, selectedLocation.value),
                      draggable: true,
                      onDragEnd: (LatLng position) {
                        // Actualizar la posición del marcador
                        onSelectLocation(
                            Pair(position.latitude, position.longitude));
                      },
                    ),
                  },
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
                ),
                RoundedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Get.back();
                      onSave();
                    }
                  },
                  color: MyColors.PRIMARY,
                  textColor: MyColors.LIGHT,
                  text: "save".tr,
                  icon: Icons.save,
                ),
                if (isEditing && onDelete != null)
                  RoundedButton(
                    onPressed: onDelete!,
                    color: MyColors.DANGER,
                    textColor: MyColors.LIGHT,
                    text: "delete".tr,
                    icon: Icons.delete,
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
