import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_origen_app/content/main/storage/controller/weather_controller.dart';
import 'package:virtual_origen_app/content/main/widgets/property_header.dart';
import 'package:virtual_origen_app/models/property.dart';
import 'package:virtual_origen_app/services/auth/interface_auth_service.dart';
import 'package:virtual_origen_app/themes/colors.dart';
import 'package:virtual_origen_app/themes/styles/my_text_styles.dart';
import 'package:virtual_origen_app/widgets/my_scaffold.dart';
import 'package:virtual_origen_app/content/main/widgets/weather_chart.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<WeatherController>();
    var authService = Get.find<IAuthService>();
    var propertySelected = Get.arguments['property'] as Property?;
    controller.setPropertySelected(propertySelected);
    return MyScaffold(
      backgroundColor: MyColors.CURRENT,
      body: WeatherBody(
        controller: controller,
        authService: authService,
      ),
    );
  }
}

class WeatherBody extends StatelessWidget {
  const WeatherBody({
    Key? key,
    required this.controller,
    required this.authService,
  }) : super(key: key);

  final WeatherController controller;
  final IAuthService authService;

  @override
  Widget build(BuildContext context) {
    // final displayCount =
    //     context.width * 25 ~/ 2560 > controller.weatherList.length
    //         ? controller.weatherList.length
    //         : context.width * 25 ~/ 2560;
    return Expanded(
      child: Column(
        children: [
          PropertyHeader(
            propertySelected: controller.propertySelected,
            authService: authService,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(15),
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: MyColors.INFO.color,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Obx(
                    () => Wrap(
                      alignment: WrapAlignment.spaceAround,
                      runAlignment: WrapAlignment.spaceAround,
                      spacing: 15,
                      children: [
                        for (var i = 0; i < 3; i++)
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                i == 0
                                    ? "temperature_title".tr
                                    : i == 1
                                        ? "wind_title".tr
                                        : "rain_title".tr,
                                style: MyTextStyles.p.textStyle.copyWith(
                                  color: MyColors.LIGHT.color,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                i == 0
                                    ? "${controller.weatherNow.value.temperature} °C"
                                    : i == 1
                                        ? "${controller.weatherNow.value.windSpeed} m/s"
                                        : "${controller.weatherNow.value.rainProbability} %",
                                style: MyTextStyles.h2.textStyle.copyWith(
                                  color: MyColors.LIGHT.color,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    color: Get.isDarkMode ? Colors.grey[800] : Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 35,
                    vertical: 15,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "chart_inversor_title".tr,
                        style: MyTextStyles.h2.textStyle.copyWith(
                          color: MyColors.CONTRARY.color,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        children: [
                          for (var i = 0; i < 3; i++)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: i == 0
                                        ? MyColors.ORANGE.color
                                        : i == 1
                                            ? MyColors.SUCCESS.color
                                            : MyColors.INFO.color,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  i == 0
                                      ? "temperature_title".tr
                                      : i == 1
                                          ? "wind_title".tr
                                          : "rain_title".tr,
                                  style: MyTextStyles.p.textStyle.copyWith(
                                    color: MyColors.CONTRARY.color,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Obx(() {
                        final displayCount = context.width * 25 ~/ 2560 >
                                controller.weatherList.length
                            ? controller.weatherList.length
                            : context.width * 25 ~/ 2560;
                        return Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 300,
                              child: WeatherChart(
                                temData: controller.temData,
                                rainData: controller.rainData,
                                windSpeedData: controller.windSpeedData,
                                dateData: controller.weatherList
                                    .map((e) => e.dateTime.end)
                                    .toList(),
                                bottomTitle: "chart_time_title".tr,
                                displayCount: displayCount,
                                offset: controller.offsetWeatherChart.value,
                              ),
                            ),
                            Slider(
                              value: controller.offsetWeatherChart.value
                                  .toDouble(),
                              onChanged: (value) => controller
                                  .offsetWeatherChart.value = value.round(),
                              min: displayCount.toDouble(),
                              max: controller.temData.length.toDouble(),
                              divisions:
                                  controller.temData.length - displayCount <= 0
                                      ? 1
                                      : controller.temData.length -
                                          displayCount,
                              activeColor: MyColors.LIGHT.color,
                            ),
                          ],
                        );
                      }),
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
