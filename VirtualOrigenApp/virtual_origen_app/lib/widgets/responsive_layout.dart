import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    Key? key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
    this.widthDesktop = 1100,
    this.widthTablet = 500,
  }) : super(key: key);
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;
  final double widthDesktop;
  final double widthTablet;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, contraints) {
        if (context.width < widthTablet) {
          return mobile;
        } else if (context.width < widthDesktop) {
          return tablet;
        } else {
          return desktop;
        }
      },
    );
  }
}
