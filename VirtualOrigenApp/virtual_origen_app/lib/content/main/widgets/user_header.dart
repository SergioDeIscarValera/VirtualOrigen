import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_origen_app/routes/app_routes.dart';
import 'package:virtual_origen_app/services/auth/interface_auth_service.dart';
import 'package:virtual_origen_app/services/repository/invitation/interface_invitation_repository.dart';
import 'package:virtual_origen_app/themes/colors.dart';
import 'package:virtual_origen_app/themes/styles/my_text_styles.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({
    Key? key,
    required this.authService,
  }) : super(key: key);

  final IAuthService authService;

  @override
  Widget build(BuildContext context) {
    final IInvitationRepository invitationRepository =
        Get.find<IInvitationRepository>();
    final RxBool haveNotification = RxBool(false);
    setHaveNotification(haveNotification, invitationRepository);
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
                "welcome".tr.replaceAll("{user}", authService.getName()),
                style: MyTextStyles.h2.textStyle.copyWith(
                  color: MyColors.LIGHT.color,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
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
                      backgroundImage: NetworkImage(
                        authService.getProfileImage(),
                      ),
                    ),
                  ),
                ),
              ),
              Obx(() {
                if (haveNotification.value) {
                  return Positioned(
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
                  );
                } else {
                  return const SizedBox();
                }
              }),
              Obx(() {
                if (haveNotification.value) {
                  return Positioned(
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
                  );
                } else {
                  return const SizedBox();
                }
              }),
            ],
          ),
        ],
      ),
    );
  }

  setHaveNotification(
      RxBool haveNoti, IInvitationRepository invitationRepository) async {
    haveNoti.value = await invitationRepository.haveNewInvitations(
        idc: authService.getEmail());
  }
}
