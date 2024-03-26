import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_origen_app/content/main/storage/controller/weather_controller.dart';
import 'package:virtual_origen_app/themes/colors.dart';
import 'package:virtual_origen_app/widgets/my_scaffold.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<WeatherController>();
    return MyScaffold(
      backgroundColor: MyColors.CONTRARY,
      body: WeatherBody(controller: controller),
    );
  }
}

class WeatherBody extends StatelessWidget {
  const WeatherBody({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final WeatherController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.CURRENT.color,
      ),
      child: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
