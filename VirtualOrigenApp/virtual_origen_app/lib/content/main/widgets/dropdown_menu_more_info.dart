import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:virtual_origen_app/content/main/storage/controller/property_controller.dart';
import 'package:virtual_origen_app/themes/colors.dart';
import 'package:virtual_origen_app/themes/styles/my_text_styles.dart';

class DropdownMenuMoreInfo extends StatelessWidget {
  const DropdownMenuMoreInfo({
    super.key,
    required this.controller,
  });

  final PropertyController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ClipRRect(
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(24),
        ),
        child: AnimatedContainer(
          margin: const EdgeInsets.only(top: 120),
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeInOut,
          height: controller.isMenuOpen.value ? 310 : 45,
          width: context.width * 0.95,
          decoration: BoxDecoration(
            color: MyColors.CONTRARY.color,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 5),
              IconButton(
                onPressed: controller.dropdowMenu,
                icon: Icon(controller.isMenuOpen.value
                    ? CupertinoIcons.chevron_up
                    : CupertinoIcons.chevron_down),
                color: MyColors.CURRENT.color,
              ),
              const SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  color: MyColors.SECONDARY.color,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/full-battery.png",
                          height: 50,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "${controller.inversorNow.value.battery} %",
                          style: MyTextStyles.h1.textStyle.copyWith(
                            color: MyColors.LIGHT.color,
                          ),
                        ),
                      ],
                    ),
                    if (context.width > 350)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.battery_saver,
                                color: MyColors.LIGHT.color,
                                size: 45,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "${controller.inversorNow.value.gain} W",
                                style: MyTextStyles.h2.textStyle.copyWith(
                                  color: MyColors.LIGHT.color,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.battery_charging_full,
                                color: MyColors.LIGHT.color,
                                size: 45,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "${controller.inversorNow.value.consumption} W",
                                style: MyTextStyles.h2.textStyle.copyWith(
                                  color: MyColors.LIGHT.color,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    Center(
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: controller.openInversorPage,
                          child: Icon(
                            Icons.open_in_full,
                            color: MyColors.LIGHT.color,
                            size: 35,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: MyColors.INFO.color,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: MyColors.CONTRARY.color.withOpacity(0.6),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Image.network(
                            controller.weatherNow.value.weatherIconUrl,
                            height: 50,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "day_long_${controller.weatherNow.value.dateTime.end.weekday}"
                              .tr,
                          style: MyTextStyles.h2.textStyle.copyWith(
                            color: MyColors.LIGHT.color,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    if (context.width > 350)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.device_thermostat,
                                color: MyColors.LIGHT.color,
                                size: 45,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "${controller.weatherNow.value.temperature} °C",
                                style: MyTextStyles.h2.textStyle.copyWith(
                                  color: MyColors.LIGHT.color,
                                ),
                              ),
                              const SizedBox(width: 15),
                              if (context.width > 800)
                                Column(
                                  children: [
                                    Text(
                                      "${controller.weatherNow.value.temperatureMin} °C",
                                      style: MyTextStyles.h3.textStyle.copyWith(
                                        color: MyColors.PURPLE.color,
                                      ),
                                    ),
                                    Text(
                                      "${controller.weatherNow.value.temperatureMax} °C",
                                      style: MyTextStyles.h3.textStyle.copyWith(
                                        color: MyColors.DANGER.color,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 15,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.water_drop_outlined,
                                    color: MyColors.LIGHT.color,
                                    size: 45,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "${controller.weatherNow.value.rainProbability} %",
                                    style: MyTextStyles.h2.textStyle.copyWith(
                                      color: MyColors.LIGHT.color,
                                    ),
                                  ),
                                ],
                              ),
                              if (context.width > 800)
                                Row(
                                  children: [
                                    Icon(
                                      Icons.air,
                                      color: MyColors.LIGHT.color,
                                      size: 45,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      "${controller.weatherNow.value.windSpeed} m/s",
                                      style: MyTextStyles.h2.textStyle.copyWith(
                                        color: MyColors.LIGHT.color,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ],
                      ),
                    Center(
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: controller.openWeatherPage,
                          child: Icon(
                            Icons.open_in_full,
                            color: MyColors.LIGHT.color,
                            size: 35,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ).animate(delay: const Duration(milliseconds: 150)).fade().slide(),
    );
  }
}
