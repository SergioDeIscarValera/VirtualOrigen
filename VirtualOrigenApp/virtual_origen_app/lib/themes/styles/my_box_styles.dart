import 'package:flutter/material.dart';
import 'package:virtual_origen_app/themes/colors.dart';

class MyBoxStyles {
  static final defaultShadow = [
    BoxShadow(
      color: MyColors.CONTRARY.color.withOpacity(0.5),
      spreadRadius: 0,
      blurRadius: 10,
      offset: const Offset(0, 5), // changes position of shadow
    ),
  ];
}
