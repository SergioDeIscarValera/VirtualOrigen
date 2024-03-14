import 'package:flutter/material.dart';
import 'package:virtual_origen_app/themes/colors.dart';
import 'package:virtual_origen_app/themes/styles/my_text_styles.dart';

class MyTextForm extends StatelessWidget {
  const MyTextForm({
    Key? key,
    required this.controller,
    required this.icon,
    required this.label,
    required this.color,
    this.obscureText = false,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final IconData icon;
  final String label;
  final MyColors color;
  final bool obscureText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: color.color,
        ),
        labelText: label,
        labelStyle: MyTextStyles.p.textStyle
            .copyWith(color: color.color.withOpacity(0.75)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: color.color.withOpacity(0.5),
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: MyColors.PRIMARY.color,
            width: 2,
          ),
        ),
        errorStyle: MyTextStyles.p.textStyle.copyWith(
          color: MyColors.DANGER.color,
          fontSize: 12,
        ),
      ),
      style: MyTextStyles.p.textStyle.copyWith(
        color: color.color,
      ),
    );
  }
}
