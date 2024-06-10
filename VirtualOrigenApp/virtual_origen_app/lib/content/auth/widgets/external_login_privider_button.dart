import 'package:flutter/material.dart';
import 'package:virtual_origen_app/themes/colors.dart';
import 'package:virtual_origen_app/themes/styles/my_text_styles.dart';

class ExternalLoginPrividerButton extends StatelessWidget {
  const ExternalLoginPrividerButton({
    Key? key,
    required this.onPressed,
    required this.image,
    this.text,
    this.tooltip,
  }) : super(key: key);

  final Function() onPressed;
  final String? tooltip;
  final String? text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Tooltip(
        message: tooltip ?? "",
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: MyColors.CONTRARY.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: MyColors.CONTRARY.color.withOpacity(0.5),
                width: 2,
              ),
            ),
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 15,
              children: [
                Image.asset(
                  image,
                  height: 30,
                  width: 30,
                ),
                if (text != null)
                  Text(
                    text!,
                    style: MyTextStyles.h3.textStyle.copyWith(
                      color: MyColors.CONTRARY.color,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
