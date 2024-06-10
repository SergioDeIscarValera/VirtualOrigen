import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:virtual_origen_app/themes/colors.dart';

class DottedCard extends StatelessWidget {
  const DottedCard({Key? key, required this.onTap}) : super(key: key);
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onTap(),
        child: DottedBorder(
          color: MyColors.CONTRARY.color,
          radius: const Radius.circular(12),
          borderType: BorderType.RRect,
          dashPattern: const [8, 4],
          strokeWidth: 2,
          child: Center(
            child: Icon(
              Icons.add,
              color: MyColors.CONTRARY.color,
              size: 50,
            ),
          ),
        ),
      ),
    );
  }
}
