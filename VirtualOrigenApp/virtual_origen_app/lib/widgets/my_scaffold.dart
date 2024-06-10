import 'package:flutter/material.dart';
import 'package:virtual_origen_app/themes/colors.dart';

class MyScaffold extends StatelessWidget {
  const MyScaffold({
    Key? key,
    required this.body,
    this.backgroundColor = MyColors.CURRENT,
  }) : super(key: key);
  final Widget body;
  final MyColors backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor.color,
      body: SafeArea(
        child: body,
      ),
    );
  }
}
