import 'package:flutter/material.dart';
import 'package:virtual_origen_app/themes/colors.dart';

class ColorDropdown extends StatelessWidget {
  const ColorDropdown({
    Key? key,
    required this.onChanged,
    required this.value,
  }) : super(key: key);
  final void Function(MyColors?) onChanged;
  final MyColors value;
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: MyColors.values
          .where((e) => e.isSelectable)
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Container(
                color: e.color,
                height: 30,
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
      value: value,
      isExpanded: true,
      borderRadius: BorderRadius.circular(12),
      underline: const SizedBox(),
    );
  }
}
