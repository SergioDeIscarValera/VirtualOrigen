import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:virtual_origen_app/content/main/storage/controller/home_controller.dart';
import 'package:virtual_origen_app/content/main/widgets/dotted_card.dart';
import 'package:virtual_origen_app/content/main/widgets/property_long_card.dart';
import 'package:virtual_origen_app/content/main/widgets/property_small_card.dart';
import 'package:virtual_origen_app/content/main/widgets/user_header.dart';
import 'package:virtual_origen_app/services/auth/interface_auth_service.dart';
import 'package:virtual_origen_app/themes/colors.dart';
import 'package:virtual_origen_app/themes/styles/my_text_styles.dart';
import 'package:virtual_origen_app/widgets/my_scaffold.dart';
import 'package:virtual_origen_app/widgets/responsive_layout.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    var authService = Get.find<IAuthService>();
    return MyScaffold(
      backgroundColor: MyColors.CURRENT,
      body: HomeBody(
        controller: controller,
        authService: authService,
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({
    Key? key,
    required this.controller,
    required this.authService,
  }) : super(key: key);

  final HomeController controller;
  final IAuthService authService;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          UserHeader(
            userName: authService.getName(),
            userImage: authService.getProfileImage(),
            haveNotification: true,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(15),
              children: [
                Text(
                  "properties".tr,
                  style: MyTextStyles.h3.textStyle,
                ),
                const SizedBox(height: 15),
                Obx(
                  () => Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 15,
                    children: controller.properties
                        .map(
                          (property) => ResponsiveLayout(
                            mobile: PropertySmallCard(
                              property: property,
                              inversorNow:
                                  controller.getInversorNow(id: property.id),
                              weatherNow:
                                  controller.getWeatherNow(id: property.id),
                              onTap: controller.navigateProperty,
                              onLongPress: controller.editPropertyDialog,
                            ),
                            tablet: SizedBox(
                              width: context.width * 0.455,
                              child: PropertySmallCard(
                                property: property,
                                inversorNow:
                                    controller.getInversorNow(id: property.id),
                                weatherNow:
                                    controller.getWeatherNow(id: property.id),
                                onTap: controller.navigateProperty,
                                onLongPress: controller.editPropertyDialog,
                              ),
                            ),
                            desktop: PropertyLongCard(
                              property: property,
                              inversorNow:
                                  controller.getInversorNow(id: property.id),
                              weatherNow:
                                  controller.getWeatherNow(id: property.id),
                              onTap: controller.navigateProperty,
                              onLongPress: controller.editPropertyDialog,
                            ),
                          ),
                        )
                        .toList()
                        .animate(interval: const Duration(milliseconds: 200))
                        .fade(begin: 0.1),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 170,
                  child: DottedCard(
                    onTap: controller.newPropertyDialog,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
