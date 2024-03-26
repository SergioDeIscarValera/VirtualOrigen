import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:virtual_origen_app/models/pair.dart';
import 'package:virtual_origen_app/models/smart_device.dart';
import 'package:virtual_origen_app/models/smart_device_type.dart';
import 'package:virtual_origen_app/themes/colors.dart';
import 'package:virtual_origen_app/themes/styles/my_text_styles.dart';

class SmartDeviceCard extends StatelessWidget {
  const SmartDeviceCard({
    Key? key,
    required this.smartDevice,
    required this.onTap,
    required this.onLongPress,
    required this.onSwitch,
  }) : super(key: key);

  final SmartDevice smartDevice;
  final Function(SmartDevice) onTap;
  final Function(SmartDevice) onLongPress;
  final Function(SmartDevice, bool) onSwitch;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => onTap(smartDevice),
            onLongPress: () => onLongPress(smartDevice),
            child: Container(
              decoration: BoxDecoration(
                color: smartDevice.color.color,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              smartDevice.type.icon,
                              color: MyColors.LIGHT.color,
                              size: 35,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                smartDevice.name,
                                style: MyTextStyles.h3.textStyle.copyWith(
                                  color: MyColors.LIGHT.color,
                                  fontSize: 24,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Tooltip(
                              message: "manual_mode".tr,
                              child: CupertinoSwitch(
                                value: smartDevice.isManualMode,
                                onChanged: (value) {
                                  onSwitch(smartDevice, value);
                                },
                                activeColor: MyColors.SUCCESS.color,
                                trackColor: MyColors.DARK.color,
                              ),
                            ),
                            const SizedBox(width: 20),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...smartDevice.timeZones.map(
                              (e) => Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Row(children: [
                                  Icon(
                                    Icons.alarm,
                                    color: MyColors.LIGHT.color,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "${e.start.hour}:${e.start.minute} - ${e.end.hour}:${e.end.minute}",
                                    style: MyTextStyles.p.textStyle.copyWith(
                                      color: MyColors.LIGHT.color,
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                            RangeRow(
                              pair: smartDevice.batteryRange,
                              icon: Icons.battery_5_bar,
                              unit: "%",
                            ),
                            RangeRow(
                              pair: smartDevice.productionRange,
                              icon: Icons.battery_saver,
                              unit: "W",
                            ),
                            RangeRow(
                              pair: smartDevice.consumptionRange,
                              icon: Icons.battery_charging_full,
                              unit: "W",
                            ),
                            RangeRow(
                              pair: smartDevice.temperatureRange,
                              icon: Icons.thermostat,
                              unit: "°C",
                            ),
                            RangeRow(
                              pair: smartDevice.rainRange,
                              icon: Icons.water_drop_outlined,
                              unit: "%",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: -3,
          top: -3,
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: MyColors.CURRENT.color,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          right: 2,
          top: 2,
          child: Tooltip(
            message:
                smartDevice.isOn ? "smart_device_on".tr : "smart_device_off".tr,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: smartDevice.isOn
                    ? MyColors.SUCCESS.color
                    : MyColors.SUCCESS_EMPHSIS.color,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class RangeRow extends StatelessWidget {
  const RangeRow(
      {Key? key, required this.pair, required this.icon, required this.unit})
      : super(key: key);
  final Pair<int, int>? pair;
  final IconData icon;
  final String unit;
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (pair == null) return const SizedBox();
      return Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: MyColors.LIGHT.color,
            ),
            const SizedBox(width: 10),
            Text(
              "${pair!.key} $unit --- ${pair!.value} $unit",
              style: MyTextStyles.p.textStyle.copyWith(
                color: MyColors.LIGHT.color,
              ),
            ),
          ],
        ),
      );
    });
  }
}
