import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_origen_app/content/main/widgets/color_dropdown.dart';
import 'package:virtual_origen_app/content/main/widgets/smart_device_type_dropdown.dart';
import 'package:virtual_origen_app/models/pair.dart';
import 'package:virtual_origen_app/models/smart_device.dart';
import 'package:virtual_origen_app/models/smart_device_type.dart';
import 'package:virtual_origen_app/themes/colors.dart';
import 'package:virtual_origen_app/themes/styles/my_text_styles.dart';
import 'package:virtual_origen_app/utils/form_validator.dart';
import 'package:virtual_origen_app/widgets/my_text_form.dart';
import 'package:virtual_origen_app/widgets/responsive_layout.dart';
import 'package:virtual_origen_app/widgets/rounded_button.dart';
import 'package:virtual_origen_app/widgets/wrap_in_mid.dart';

import 'package:virtual_origen_app/widgets/my_multi_time_picker.dart';
import 'my_range_expansion.dart';

class SmartDeviceDialog extends StatelessWidget {
  const SmartDeviceDialog(
      {Key? key,
      this.smartDevice,
      required this.onSave,
      required this.onDelete})
      : super(key: key);
  final SmartDevice? smartDevice;
  final Function(SmartDevice) onSave;
  final Function(SmartDevice) onDelete;
  @override
  Widget build(BuildContext context) {
    var validator = Get.find<FormValidator>();
    return ResponsiveLayout(
      mobile: Dialog.fullscreen(
        backgroundColor: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.all(10),
          child: SmartDeviceDialogBody(
            validator: validator,
            smartDevice: smartDevice,
            onSave: onSave,
            onDelete: onDelete,
          ),
        ),
      ),
      tablet: Dialog(
        child: SmartDeviceDialogBody(
          validator: validator,
          smartDevice: smartDevice,
          onSave: onSave,
          onDelete: onDelete,
        ),
      ),
      desktop: WrapInMid(
        child: Dialog(
          child: SmartDeviceDialogBody(
            validator: validator,
            smartDevice: smartDevice,
            onSave: onSave,
            onDelete: onDelete,
          ),
        ),
      ),
    );
  }
}

class SmartDeviceDialogBody extends StatelessWidget {
  const SmartDeviceDialogBody({
    Key? key,
    required this.validator,
    this.smartDevice,
    required this.onSave,
    required this.onDelete,
  }) : super(key: key);
  final FormValidator validator;
  final SmartDevice? smartDevice;
  final Function(SmartDevice) onSave;
  final Function(SmartDevice) onDelete;
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var nameController = TextEditingController(text: smartDevice?.name);
    final Rx<MyColors> color = smartDevice != null
        ? smartDevice!.color.obs
        : MyColors.values.firstWhere((e) => e.isSelectable).obs;
    final Rx<SmartDeviceType> smartDeviceType =
        smartDevice != null ? smartDevice!.type.obs : SmartDeviceType.OTHER.obs;
    final RxList<DateTimeRange> timeZones = smartDevice != null
        ? smartDevice!.timeZones.obs
        : <DateTimeRange>[].obs;
    final RxList<bool> days = smartDevice != null
        ? smartDevice!.days.obs
        : <bool>[true, true, true, true, true, true, true].obs;
    final Rx<RangeValues> batteryRange =
        smartDevice != null && smartDevice!.batteryRange != null
            ? RangeValues(smartDevice!.batteryRange!.key.toDouble(),
                    smartDevice!.batteryRange!.value.toDouble())
                .obs
            : const RangeValues(0, 100).obs;
    final RxBool isBatteryActive =
        smartDevice != null && smartDevice!.batteryRange != null
            ? true.obs
            : false.obs;
    final Rx<RangeValues> productionRange =
        smartDevice != null && smartDevice!.productionRange != null
            ? RangeValues(smartDevice!.productionRange!.key.toDouble(),
                    smartDevice!.productionRange!.value.toDouble())
                .obs
            : const RangeValues(0, 9999).obs;
    final RxBool isProductionActive =
        smartDevice != null && smartDevice!.productionRange != null
            ? true.obs
            : false.obs;
    final Rx<RangeValues> consumptionRange =
        smartDevice != null && smartDevice!.consumptionRange != null
            ? RangeValues(smartDevice!.consumptionRange!.key.toDouble(),
                    smartDevice!.consumptionRange!.value.toDouble())
                .obs
            : const RangeValues(0, 9999).obs;
    final RxBool isConsumptionActive =
        smartDevice != null && smartDevice!.consumptionRange != null
            ? true.obs
            : false.obs;
    final Rx<RangeValues> temperatureRange =
        smartDevice != null && smartDevice!.temperatureRange != null
            ? RangeValues(smartDevice!.temperatureRange!.key.toDouble(),
                    smartDevice!.temperatureRange!.value.toDouble())
                .obs
            : const RangeValues(-20, 60).obs;
    final RxBool isTemperatureActive =
        smartDevice != null && smartDevice!.temperatureRange != null
            ? true.obs
            : false.obs;
    final Rx<RangeValues> rainRange =
        smartDevice != null && smartDevice!.rainRange != null
            ? RangeValues(smartDevice!.rainRange!.key.toDouble(),
                    smartDevice!.rainRange!.value.toDouble())
                .obs
            : const RangeValues(0, 100).obs;
    final RxBool isRainActive =
        smartDevice != null && smartDevice!.rainRange != null
            ? true.obs
            : false.obs;

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
                smartDevice != null
                    ? "edit_smart_device".tr
                    : "new_smart_device".tr,
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
                label: "smart_device_name".tr,
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
              // Time Zones
              MyMultiTimePicker(
                timeZones: smartDevice?.timeZones ?? [],
                onChanged: (value) {
                  timeZones.clear();
                  timeZones.addAll(value);
                },
              ),
              const SizedBox(height: 20),
              // Days
              Wrap(
                alignment: WrapAlignment.spaceEvenly,
                spacing: 10,
                children: [
                  for (var i = 0; i < 7; i++)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "day_${i + 1}".tr,
                          style: MyTextStyles.p.textStyle,
                        ),
                        Obx(
                          () => Checkbox(
                            value: days[i],
                            onChanged: (value) => days[i] = value!,
                            //activeColor: MyColors.CURRENT.color,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              const SizedBox(height: 20),
              // Battery Range
              MyRangeExpansion(
                valueRange: batteryRange,
                title: "battery_range_title".tr,
                subtitle: "battery_range_reason".tr,
                unit: "%",
                leading: Icons.battery_charging_full,
                color: MyColors.WARNING,
                range: Pair(0, 100),
                isActive: isBatteryActive,
              ),
              const SizedBox(height: 20),
              // Production Range
              MyRangeExpansion(
                valueRange: productionRange,
                title: "production_range_title".tr,
                subtitle: "production_range_reason".tr,
                unit: "W",
                leading: Icons.battery_saver,
                color: MyColors.SUCCESS,
                range: Pair(0, 9999),
                isActive: isProductionActive,
              ),
              const SizedBox(height: 20),
              // Consumption Range
              MyRangeExpansion(
                valueRange: consumptionRange,
                title: "consumption_range_title".tr,
                subtitle: "consumption_range_reason".tr,
                unit: "W",
                leading: Icons.battery_charging_full,
                color: MyColors.DANGER,
                range: Pair(0, 9999),
                isActive: isConsumptionActive,
              ),
              const SizedBox(height: 20),
              // Temperature Range
              MyRangeExpansion(
                valueRange: temperatureRange,
                title: "temperature_range_title".tr,
                subtitle: "temperature_range_reason".tr,
                unit: "°C",
                leading: Icons.device_thermostat,
                color: MyColors.ORANGE,
                range: Pair(-20, 60),
                isActive: isTemperatureActive,
              ),
              const SizedBox(height: 20),
              // Rain Range
              MyRangeExpansion(
                valueRange: rainRange,
                title: "rain_range_title".tr,
                subtitle: "rain_range_reason".tr,
                unit: "%",
                leading: Icons.water_drop_outlined,
                color: MyColors.INFO,
                range: Pair(0, 100),
                isActive: isRainActive,
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
                        var newSmartDevice = SmartDevice(
                          id: smartDevice?.id,
                          name: nameController.text,
                          color: color.value,
                          type: smartDeviceType.value,
                          timeZones: timeZones.toList(),
                          days: days.toList(),
                          batteryRange: isBatteryActive.value
                              ? Pair(batteryRange.value.start.toInt(),
                                  batteryRange.value.end.toInt())
                              : null,
                          productionRange: isProductionActive.value
                              ? Pair(productionRange.value.start.toInt(),
                                  productionRange.value.end.toInt())
                              : null,
                          consumptionRange: isConsumptionActive.value
                              ? Pair(consumptionRange.value.start.toInt(),
                                  consumptionRange.value.end.toInt())
                              : null,
                          temperatureRange: isTemperatureActive.value
                              ? Pair(temperatureRange.value.start.toInt(),
                                  temperatureRange.value.end.toInt())
                              : null,
                          rainRange: isRainActive.value
                              ? Pair(rainRange.value.start.toInt(),
                                  rainRange.value.end.toInt())
                              : null,
                        );
                        onSave(newSmartDevice);
                      }
                    },
                    color: MyColors.PRIMARY,
                    textColor: MyColors.LIGHT,
                    text: "save".tr,
                    icon: Icons.save,
                    isSmall: context.width < 550,
                  ),
                  if (smartDevice != null)
                    RoundedButton(
                      onPressed: () => onDelete(smartDevice!),
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
