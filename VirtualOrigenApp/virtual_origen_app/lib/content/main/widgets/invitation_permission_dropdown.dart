import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_origen_app/models/invitation_permission.dart';
import 'package:virtual_origen_app/themes/colors.dart';
import 'package:virtual_origen_app/themes/styles/my_text_styles.dart';

class InvitationPermissionDropdown extends StatelessWidget {
  const InvitationPermissionDropdown({
    Key? key,
    required this.onChanged,
    required this.value,
  }) : super(key: key);
  final void Function(InvitationPermission?) onChanged;
  final InvitationPermission value;
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: InvitationPermission.values
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Row(
                children: [
                  Icon(e.icon, color: MyColors.CONTRARY.color),
                  const SizedBox(width: 10),
                  Text(
                    e.token.tr,
                    style: MyTextStyles.p.textStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
      value: value,
      isExpanded: true,
      borderRadius: BorderRadius.circular(12),
      underline: const SizedBox(),
    );
  }
}
