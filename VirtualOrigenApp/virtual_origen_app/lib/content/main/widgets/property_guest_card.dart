import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_origen_app/models/invitation_permission.dart';
import 'package:virtual_origen_app/models/property.dart';
import 'package:virtual_origen_app/themes/colors.dart';
import 'package:virtual_origen_app/themes/styles/my_text_styles.dart';

class PropertyGuestCard extends StatelessWidget {
  const PropertyGuestCard({
    Key? key,
    required this.propertyGuest,
    required this.onPermissionChange,
    required this.onRemove,
  }) : super(key: key);
  final PropertyGuest propertyGuest;
  final Function(String, InvitationPermission) onPermissionChange;
  final Function(String) onRemove;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Tooltip(
          message: propertyGuest.guestEmail,
          child: Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              color: MyColors.CONTRARY.color,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Builder(
                builder: (context) {
                  if (propertyGuest.state == 0) {
                    return Icon(
                      Icons.help,
                      color: MyColors.CURRENT.color,
                      size: 50,
                    );
                  }
                  // return Image.network(
                  //   propertyGuest.guestProfileImage,
                  //   width: 50,
                  //   height: 50,
                  //   loadingBuilder: (context, child, loadingProgress) {
                  //     if (loadingProgress == null) return child;
                  //     return Center(
                  //       child: CircularProgressIndicator(
                  //         value: loadingProgress.expectedTotalBytes != null
                  //             ? loadingProgress.cumulativeBytesLoaded /
                  //                 loadingProgress.expectedTotalBytes!
                  //             : null,
                  //       ),
                  //     );
                  //   },
                  //   errorBuilder: (context, error, stackTrace) => Text(
                  //     error.toString(),
                  //     style: MyTextStyles.p.textStyle.copyWith(
                  //       color: MyColors.DANGER.color,
                  //     ),
                  //   ),
                  // );
                  return CircleAvatar(
                    radius: 30,
                    backgroundColor: MyColors.CONTRARY.color,
                    backgroundImage: NetworkImage(
                      propertyGuest.guestProfileImage,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                Get.dialog(
                  AlertDialog(
                    backgroundColor: MyColors.CURRENT.color,
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            propertyGuest.guestEmail,
                            style: MyTextStyles.h3.textStyle,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () => onRemove(propertyGuest.guestEmail),
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Container(
                              width: 35,
                              height: 35,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: MyColors.DANGER.color,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.delete,
                                  color: MyColors.LIGHT.color,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    content: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        for (var permission in InvitationPermission.values)
                          GestureDetector(
                            onTap: () {
                              if (permission != propertyGuest.permission) {
                                onPermissionChange(
                                    propertyGuest.guestEmail, permission);
                              }
                            },
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Container(
                                height: 50,
                                width: 50,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: permission == propertyGuest.permission
                                      ? permission.color.color
                                      : permission.color.inverse,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Icon(
                                    permission.icon,
                                    color:
                                        permission == propertyGuest.permission
                                            ? MyColors.LIGHT.color
                                            : MyColors.LIGHT.inverse,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  color: MyColors.INFO.color,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.more_vert,
                    color: MyColors.LIGHT.color,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
