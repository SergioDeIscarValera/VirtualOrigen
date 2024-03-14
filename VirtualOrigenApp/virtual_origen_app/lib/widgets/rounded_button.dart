import 'package:flutter/material.dart';
import 'package:virtual_origen_app/themes/colors.dart';
import 'package:virtual_origen_app/themes/styles/my_text_styles.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.onPressed,
    required this.color,
    required this.textColor,
    this.text,
    this.icon,
    this.tooltip,
  }) : super(key: key);

  final Function() onPressed;
  final String? tooltip;
  final String? text;
  final IconData? icon;
  final MyColors color;
  final MyColors textColor;

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
                color: color.color,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  if (icon != null) Icon(icon, color: textColor.color),
                  if (icon != null && text != null) const SizedBox(width: 10),
                  if (text != null)
                    Text(
                      text!,
                      style: MyTextStyles.p.textStyle.copyWith(
                        color: textColor.color,
                      ),
                    ),
                ],
              ),
            ),
          )),
    );
  }
}
