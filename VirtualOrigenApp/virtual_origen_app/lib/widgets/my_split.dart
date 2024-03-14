import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_origen_app/themes/colors.dart';
import 'package:virtual_origen_app/themes/styles/my_text_styles.dart';

class MySplit extends StatelessWidget {
  const MySplit({Key? key, this.text, this.thickness = 3}) : super(key: key);
  final String? text;
  final double thickness;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            color: MyColors.CONTRARY.color.withOpacity(0.5),
            height: 1,
            thickness: thickness,
            indent: 20,
            endIndent: 20,
          ),
        ),
        Text(
          text ?? "or".tr,
          style: MyTextStyles.h3.textStyle.copyWith(
            color: MyColors.CONTRARY.color,
          ),
        ),
        Expanded(
          child: Divider(
            color: MyColors.CONTRARY.color.withOpacity(0.5),
            height: 1,
            thickness: thickness,
            indent: 20,
            endIndent: 20,
          ),
        ),
      ],
    );
  }
}
