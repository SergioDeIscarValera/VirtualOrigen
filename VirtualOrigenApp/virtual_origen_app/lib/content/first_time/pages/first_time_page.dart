import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:virtual_origen_app/content/first_time/storage/controller/first_time_controller.dart';
import 'package:virtual_origen_app/themes/colors.dart';
import 'package:virtual_origen_app/themes/styles/my_text_styles.dart';
import 'package:virtual_origen_app/widgets/my_scaffold.dart';
import 'package:virtual_origen_app/widgets/responsive_layout.dart';
import 'package:virtual_origen_app/widgets/rounded_button.dart';
import 'package:virtual_origen_app/widgets/wrap_in_mid.dart';

class FirstTimePage extends StatelessWidget {
  const FirstTimePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var firstTimeController = Get.find<FirstTimeController>();
    return MyScaffold(
      body: ResponsiveLayout(
        mobile: FirstTimeBody(
          controller: firstTimeController,
        ),
        tablet: FirstTimeBody(
          controller: firstTimeController,
        ),
        desktop: WrapInMid(
          child: FirstTimeBody(
            controller: firstTimeController,
          ),
        ),
      ),
    );
  }
}

class FirstTimeBody extends StatelessWidget {
  const FirstTimeBody({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final FirstTimeController controller;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        PageView(
          controller: controller.pageController,
          children: [
            FirstTimeBodyView(
              text: "first_time_first_body".tr,
              image: "assets/images/solar-panel.png",
            ),
            FirstTimeBodyView(
              text: "first_time_second_body".tr,
              children: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/full-battery.png",
                    width: 150,
                  ),
                  const SizedBox(width: 10),
                  Image.asset(
                    "assets/images/low-charge.png",
                    width: 150,
                  ),
                ],
              ),
            ),
            FirstTimeBodyView(
              text: "first_time_third_body".tr,
              image: "assets/images/smart-home.png",
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          alignment: const Alignment(0, 0.9),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 50),
              SmoothPageIndicator(
                controller: controller.pageController,
                count: 3,
                effect: ExpandingDotsEffect(
                  dotColor: MyColors.CONTRARY.color,
                  activeDotColor: MyColors.PRIMARY.color,
                  expansionFactor: 2.5,
                ),
              ),
              const SizedBox(height: 50),
              Obx(
                () => RoundedButton(
                  text: controller.currentPage.value == 2
                      ? "get_started".tr
                      : "next".tr,
                  color: MyColors.PRIMARY,
                  textColor: MyColors.CURRENT,
                  onPressed: controller.nextPage,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FirstTimeBodyView extends StatelessWidget {
  const FirstTimeBodyView({
    Key? key,
    required this.text,
    this.image,
    this.children,
  }) : super(key: key);

  final String text;
  final Widget? children;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.CURRENT.color,
      margin: const EdgeInsets.only(bottom: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (image != null)
            Image.asset(
              image!,
              height: 200,
            ),
          if (children != null) children!,
          const SizedBox(height: 50),
          Text(
            text,
            style: MyTextStyles.p.textStyle.copyWith(fontSize: 24),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
