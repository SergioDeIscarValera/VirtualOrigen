import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_origen_app/routes/app_routes.dart';
import 'package:virtual_origen_app/themes/colors.dart';
import 'package:virtual_origen_app/themes/styles/my_text_styles.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({
    Key? key,
    required this.userName,
    required this.userImage,
    this.haveNotification = false,
    this.haveProfile = true,
  }) : super(key: key);

  final String userName;
  final String userImage;
  final bool haveNotification;
  final bool haveProfile;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: MyColors.PRIMARY.color,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.all(15),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Text(
                "welcome".tr.replaceAll("{user}", userName),
                style: MyTextStyles.h2.textStyle.copyWith(
                  color: MyColors.LIGHT.color,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          if (haveProfile)
            Stack(
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.USER.path);
                    },
                    child: Hero(
                      tag: "user_image",
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: MyColors.CONTRARY.color,
                        backgroundImage: NetworkImage(userImage),
                      ),
                    ),
                  ),
                ),
                if (haveNotification)
                  Positioned(
                    right: -3,
                    top: -3,
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: MyColors.PRIMARY.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                if (haveNotification)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        color: MyColors.DANGER.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
