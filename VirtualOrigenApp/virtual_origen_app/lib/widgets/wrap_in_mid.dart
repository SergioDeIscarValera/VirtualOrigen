import 'package:flutter/material.dart';

class WrapInMid extends StatelessWidget {
  const WrapInMid({
    super.key,
    required this.child,
    this.flex = 2,
    this.otherFlex = 1,
  });

  final Widget child;
  final int flex;
  final int otherFlex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(flex: otherFlex, child: const SizedBox()),
        Flexible(
          flex: flex,
          child: child,
        ),
        Flexible(flex: otherFlex, child: const SizedBox()),
      ],
    );
  }
}
