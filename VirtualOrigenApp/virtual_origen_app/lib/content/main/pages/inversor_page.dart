import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:virtual_origen_app/content/main/storage/controller/inversor_controller.dart';
import 'package:virtual_origen_app/content/main/widgets/user_header.dart';
import 'package:virtual_origen_app/models/property.dart';
import 'package:virtual_origen_app/services/auth/interface_auth_service.dart';
import 'package:virtual_origen_app/themes/colors.dart';
import 'package:virtual_origen_app/themes/styles/my_text_styles.dart';
import 'package:virtual_origen_app/widgets/my_scaffold.dart';
import 'package:virtual_origen_app/widgets/responsive_layout.dart';

import '../widgets/inversor_chart.dart';

class InversorPage extends StatelessWidget {
  const InversorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<InversorController>();
    var authService = Get.find<IAuthService>();
    var propertySelected = Get.arguments['property'] as Property?;
    controller.setPropertySelected(propertySelected);
    return MyScaffold(
      backgroundColor: MyColors.CURRENT,
      body: ResponsiveLayout(
        desktop: InversorBody(controller: controller, authService: authService),
        tablet: InversorBody(controller: controller, authService: authService),
        mobile: InversorBody(controller: controller, authService: authService),
      ),
    );
  }
}

class InversorBody extends StatelessWidget {
  const InversorBody({
    Key? key,
    required this.controller,
    required this.authService,
  }) : super(key: key);

  final InversorController controller;
  final IAuthService authService;

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd hh:mm');
    // final displayCount = context.width < 500
    //     ? 4 > controller.batteryData.length
    //         ? controller.batteryData.length
    //         : 4
    //     : context.width < 1100
    //         ? 8 > controller.batteryData.length
    //             ? controller.batteryData.length
    //             : 8
    //         : 12 > controller.batteryData.length
    //             ? controller.batteryData.length
    //             : 12;
    final displayCount =
        context.width * 25 ~/ 2560 > controller.batteryData.length
            ? controller.batteryData.length
            : context.width * 25 ~/ 2560;
    return Expanded(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
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
                Container(
                  decoration: BoxDecoration(
                    color: MyColors.SECONDARY.color,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.battery_saver,
                                color: MyColors.LIGHT.color,
                              ),
                              const SizedBox(width: 10),
                              Tooltip(
                                message: "consumption_reason".tr,
                                child: Text(
                                  "${controller.inversorNow.value.consumption.toInt()} W",
                                  style: MyTextStyles.p.textStyle.copyWith(
                                    color: MyColors.LIGHT.color,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: Row(
                            children: [
                              Expanded(
                                child: LinearProgressIndicator(
                                  value: controller.inversorNow.value.battery /
                                      100,
                                  borderRadius: BorderRadius.circular(12),
                                  minHeight: 20,
                                  backgroundColor: MyColors.LIGHT.color,
                                  valueColor: AlwaysStoppedAnimation(
                                    controller.inversorNow.value.battery < 15
                                        ? MyColors.DANGER.color
                                        : controller.inversorNow.value.battery <
                                                40
                                            ? MyColors.WARNING.color
                                            : MyColors.SUCCESS.color,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "${controller.inversorNow.value.battery.toInt()} %",
                                style: MyTextStyles.p.textStyle.copyWith(
                                  color: MyColors.LIGHT.color,
                                  fontSize: 22,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.battery_charging_full,
                                color: MyColors.LIGHT.color,
                              ),
                              const SizedBox(width: 10),
                              Tooltip(
                                message: "gain_reason".tr,
                                child: Text(
                                  "${controller.inversorNow.value.gain.toInt()} W",
                                  style: MyTextStyles.p.textStyle.copyWith(
                                    color: MyColors.LIGHT.color,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Container(
                  decoration: BoxDecoration(
                    color: MyColors.INFO.color,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.only(
                      top: 15, bottom: 10, right: 35, left: 10),
                  child: Column(
                    children: [
                      Text(
                        "chart_inversor_title".tr,
                        style: MyTextStyles.h2.textStyle.copyWith(
                          color: MyColors.LIGHT.color,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: 300,
                        child: Obx(
                          () => InversorChart(
                            batteryData: controller.batteryData,
                            gainData: controller.gainData,
                            consumptionData: controller.consumptionData,
                            dateData: controller.inversorYerserday
                                .map((element) => element.dateTime)
                                .toList(),
                            leftTitle: "chart_battery_title".tr,
                            bottomTitle: "chart_time_title".tr,
                            formatter: formatter,
                            displayCount: displayCount,
                            offset: controller.offsetBatteryChart.value,
                          ),
                        ),
                      ),
                      Obx(
                        () => Slider(
                          value: controller.offsetBatteryChart.value.toDouble(),
                          onChanged: (value) => controller
                              .offsetBatteryChart.value = value.round(),
                          min: displayCount.toDouble(),
                          max: controller.batteryData.length.toDouble(),
                          divisions:
                              controller.batteryData.length - displayCount <= 0
                                  ? 1
                                  : controller.batteryData.length -
                                      displayCount,
                          activeColor: MyColors.LIGHT.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
