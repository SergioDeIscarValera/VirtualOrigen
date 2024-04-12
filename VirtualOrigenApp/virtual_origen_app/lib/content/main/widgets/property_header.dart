import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:virtual_origen_app/content/main/widgets/user_header.dart';
import 'package:virtual_origen_app/models/property.dart';
import 'package:virtual_origen_app/services/auth/interface_auth_service.dart';
import 'package:virtual_origen_app/themes/colors.dart';
import 'package:virtual_origen_app/themes/styles/my_text_styles.dart';

class PropertyHeader extends StatelessWidget {
  const PropertyHeader({
    super.key,
    required this.propertySelected,
    required this.authService,
  });

  final Rx<Property> propertySelected;
  final IAuthService authService;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Obx(
          () => Container(
            decoration: BoxDecoration(
              color: propertySelected.value.color.color,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(24),
              ),
            ),
            padding: const EdgeInsets.only(
              top: 77,
              bottom: 2,
              left: 10,
              right: 10,
            ),
            child: Center(
              child: Text(
                propertySelected.value.name,
                style: MyTextStyles.h1.textStyle.copyWith(
                  color: MyColors.LIGHT.color,
                ),
              ),
            ),
          ).animate().fade().slide(),
        ),
        UserHeader(authService: authService),
      ],
    );
  }
}
