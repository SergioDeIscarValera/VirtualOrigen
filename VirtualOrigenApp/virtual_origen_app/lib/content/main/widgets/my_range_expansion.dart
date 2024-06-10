import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_origen_app/models/pair.dart';
import 'package:virtual_origen_app/themes/colors.dart';
import 'package:virtual_origen_app/themes/styles/my_text_styles.dart';

class MyRangeExpansion extends StatelessWidget {
  const MyRangeExpansion({
    super.key,
    required this.valueRange,
    required this.title,
    required this.range,
    required this.subtitle,
    required this.unit,
    required this.leading,
    required this.color,
    required this.isActive,
  });

  final String title;
  final String subtitle;
  final String unit;
  final IconData leading;
  final MyColors color;
  final Pair<int, int> range;
  final Rx<RangeValues> valueRange;
  final RxBool isActive;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ExpansionTile(
        title: Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              title,
              style: MyTextStyles.p.textStyle,
              textAlign: TextAlign.center,
            ),
            Checkbox(
              value: isActive.value,
              onChanged: (value) {
                isActive.value = value!;
              },
            ),
          ],
        ),
        subtitle: Text(subtitle),
        leading: Icon(
          leading,
          color: color.color,
        ),
        expandedAlignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "${valueRange.value.start.toInt()} $unit",
                style: MyTextStyles.p.textStyle
                    .copyWith(color: MyColors.INFO.color),
              ),
              Text(
                "${valueRange.value.end.toInt()} $unit",
                style: MyTextStyles.p.textStyle.copyWith(
                  color: MyColors.DANGER.color,
                ),
              ),
            ],
          ),
          RangeSlider(
            activeColor: color.color,
            values: valueRange.value,
            divisions: range.value,
            min: range.key.toDouble(),
            max: range.value.toDouble(),
            onChanged: (value) {
              valueRange.value = value;
            },
          ),
        ],
      ),
    );
  }
}
