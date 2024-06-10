import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_origen_app/models/smart_device_type.dart';
import 'package:virtual_origen_app/themes/colors.dart';
import 'package:virtual_origen_app/themes/styles/my_text_styles.dart';

class SmartDeviceTypeDropdown extends StatelessWidget {
  const SmartDeviceTypeDropdown({
    Key? key,
    required this.onChanged,
    required this.value,
    this.editable = true,
  }) : super(key: key);
  final void Function(SmartDeviceType?) onChanged;
  final SmartDeviceType value;
  final bool editable;
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: SmartDeviceType.values
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Row(
                children: [
                  Icon(e.icon, color: MyColors.CONTRARY.color),
                  const SizedBox(width: 10),
                  Text(
                    e.token.tr,
                    style: MyTextStyles.p.textStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (editable) onChanged(value);
      },
      value: value,
      isExpanded: true,
      borderRadius: BorderRadius.circular(12),
      underline: const SizedBox(),
    );
  }
}
