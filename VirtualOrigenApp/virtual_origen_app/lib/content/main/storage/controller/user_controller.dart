import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:virtual_origen_app/models/invitation.dart';
import 'package:virtual_origen_app/services/auth/interface_auth_service.dart';
import 'package:virtual_origen_app/services/repository/invitation/interface_invitation_repository.dart';
import 'package:virtual_origen_app/services/repository/property/interface_property_repository.dart';
import 'package:virtual_origen_app/services/storage/interface_local_storage.dart';
import 'package:virtual_origen_app/themes/colors.dart';
import 'package:virtual_origen_app/themes/styles/my_text_styles.dart';
import 'package:virtual_origen_app/utils/my_snackbar.dart';
import 'package:virtual_origen_app/utils/storage_keys.dart';

class UserController extends GetxController {
  late final IAuthService _authService;
  late final IInvitationRepository _invitationRepository;
  late final IPropertyRepository _propertyRepository;
  late final MySnackbar _mySnackbar;
  late final ILocalStorage _localStorage;

  final ImagePicker _picker = ImagePicker();

  final RxString profileImage = ''.obs;
  final nameController = TextEditingController();
  final RxList<Invitation> newInvitations = <Invitation>[].obs;
  final RxList<Invitation> oldInvitations = <Invitation>[].obs;

  @override
  void onInit() {
    _authService = Get.find<IAuthService>();
    _invitationRepository = Get.find<IInvitationRepository>();
    _propertyRepository = Get.find<IPropertyRepository>();
    _localStorage = Get.find<ILocalStorage>();
    _mySnackbar = Get.find<MySnackbar>();
    _invitationRepository.addListener(
        idc: _authService.getEmail(),
        listener: (invitations) {
          newInvitations.clear();
          oldInvitations.clear();
          for (var invitation in invitations) {
            if (!invitation.state) {
              newInvitations.add(invitation);
            } else {
              oldInvitations.add(invitation);
            }
          }
        });
    reset();
    super.onInit();
  }

  void processInvitation(Invitation invitation, bool newState) async {
    if (newState) {
      var newInvi = invitation.copyWith(
        state: newState,
      );
      await _invitationRepository.save(
        entity: newInvi,
        idc: _authService.getEmail(),
      );
    } else {
      _deleteInvitation(invitation);
    }
    _setNewInvitationState(invitation, newState);
  }

  void removeInvitation(Invitation invitation) async {
    _setNewInvitationState(invitation, false);
    _deleteInvitation(invitation);
  }

  void _setNewInvitationState(Invitation invitation, bool newState) async {
    var newProperty = await _propertyRepository.findById(
      id: invitation.propertyId,
      idc: invitation.ownerId,
    );
    if (newProperty == null) {
      return;
    }
    newProperty = newProperty.copyWith(
      guests: newProperty.guests
          .map((e) => e.guestEmail == _authService.getEmail()
              ? e.copyWith(
                  state: newState ? 1 : 2,
                  guestProfileImage: _authService.getProfileImage())
              : e)
          .toList(),
    );
    await _propertyRepository.save(
      entity: newProperty,
      idc: invitation.ownerId,
    );
  }

  void _deleteInvitation(Invitation invitation) {
    _invitationRepository.deleteById(
      id: invitation.propertyId,
      idc: _authService.getEmail(),
    );
  }

  void mackAsReaded() {
    for (var invitation in newInvitations) {
      if (!invitation.isNew) {
        continue;
      }
      var newInvi = invitation.copyWith(
        isNew: false,
      );
      _invitationRepository.save(
        entity: newInvi,
        idc: _authService.getEmail(),
      );
    }
  }

  void pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Limit size to 3MBS
      var size = (await pickedFile.readAsBytes()).lengthInBytes;
      if (size > (3 * 1024 * 1024)) {
        _mySnackbar.snackError("image_size_too_big".tr);
        return;
      }
      profileImage.value = pickedFile.path;
    }
  }

  void reset() {
    profileImage.value = _authService.getProfileImage();
    nameController.text = _authService.getName();
  }

  void saveUserData() {
    if (profileImage.value == _authService.getProfileImage() &&
        nameController.text == _authService.getName()) {
      return;
    }
    if (GetPlatform.isWeb) {
      _mySnackbar.snackWarning('web_not_support_change_user_data'.tr);
      return;
    }
    _authService.changeUserData(
      name: nameController.text,
      profileImage: profileImage.value,
      onSuccess: () {
        _mySnackbar.snackSuccess('user_data_updated'.tr);
        reset();
      },
      onError: (error) {
        _mySnackbar.snackError(error);
      },
    );
  }

  signOut() {
    Get.defaultDialog(
      title: "sing_out".tr,
      titleStyle: MyTextStyles.h2.textStyle.copyWith(
        color: MyColors.CONTRARY.color,
      ),
      middleText: "sing_out_message".tr,
      middleTextStyle: MyTextStyles.p.textStyle,
      textConfirm: "apply".tr,
      textCancel: "cancel".tr,
      confirmTextColor: MyColors.CURRENT.color,
      backgroundColor: MyColors.CURRENT.color,
      buttonColor: MyColors.CONTRARY.color,
      cancelTextColor: MyColors.CONTRARY.color,
      onConfirm: () async {
        await _authService.signOut();
      },
    );
  }

  changeTheme() async {
    Get.changeTheme(Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
    if (!GetPlatform.isWeb) {
      _localStorage.saveData(
        StorageKeys.THEME_MODE.key,
        !Get.isDarkMode,
      );
    }
    await Future.delayed(const Duration(milliseconds: 250));
    Get.forceAppUpdate();
  }

  changeLanguage() async {
    Get.updateLocale(
      Get.locale?.languageCode == 'en'
          ? const Locale('es')
          : const Locale('en'),
    );
    if (!GetPlatform.isWeb) {
      _localStorage.saveData(
        StorageKeys.LANGUAGE.key,
        Get.locale?.languageCode,
      );
    }
    await Future.delayed(const Duration(milliseconds: 250));
    Get.forceAppUpdate();
  }
}
