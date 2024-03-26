import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_origen_app/content/main/widgets/property_dialog.dart';
import 'package:virtual_origen_app/models/inversor_now.dart';
import 'package:virtual_origen_app/models/pair.dart';
import 'package:virtual_origen_app/models/property.dart';
import 'package:virtual_origen_app/routes/app_routes.dart';
import 'package:virtual_origen_app/services/auth/interface_auth_service.dart';
import 'package:virtual_origen_app/services/repository/inversor_now/inversor_now_firebase_repository.dart';
import 'package:virtual_origen_app/services/repository/property/interface_property_repository.dart';
import 'package:virtual_origen_app/themes/colors.dart';
import 'package:virtual_origen_app/utils/my_snackbar.dart';

class HomeController extends GetxController {
  late IPropertyRepository _propertyRepository;
  late InversorNowFirebaseRepository _inversorNowRepository;
  late IAuthService _authService;
  late MySnackbar _mySnackbar;

  final RxList<Property> properties = <Property>[].obs;

  final TextEditingController propertyNameController = TextEditingController();
  final Rx<MyColors> color = MyColors.PRIMARY.obs;
  final Rx<Pair<double, double>> location =
      Pair(40.4176833585554, -3.7038147983551027).obs;

  @override
  void onInit() {
    _authService = Get.find<IAuthService>();
    _inversorNowRepository = Get.find<InversorNowFirebaseRepository>();
    _propertyRepository = Get.find<IPropertyRepository>();
    _mySnackbar = Get.find<MySnackbar>();
    _propertyRepository.addListener(
      idc: _authService.getUid(),
      listener: (properties) {
        this.properties.value = properties;
      },
    );

    super.onInit();
  }

  @override
  void onClose() {
    _propertyRepository.removeListener(idc: _authService.getUid());
    super.onClose();
  }

  void newPropertyDialog() {
    var dialog = Get.dialog(
      PropertyDialog(
        nameController: propertyNameController,
        color: color,
        onChangedColor: (MyColors? color) {
          this.color.value = color!;
        },
        onSelectLocation: (location) {
          this.location.value = location;
        },
        selectedLocation: location.value,
        onSave: () async {
          final property = Property(
            name: propertyNameController.text,
            color: color.value,
            location: location.value,
          );
          var result = await _propertyRepository.save(
            entity: property,
            idc: _authService.getUid(),
          );
          if (result != null) {
            _mySnackbar.snackSuccess('Property saved');
          } else {
            _mySnackbar.snackError('Error saving property');
          }
        },
      ),
    );
    dialog.then((value) {
      _clear();
    });
  }

  void navigateProperty(Property property) {
    Get.toNamed(
      Routes.PROPERTY.path,
      arguments: {
        "property": property,
      },
    );
  }

  void editPropertyDialog(Property property) {
    propertyNameController.text = property.name;
    color.value = property.color;
    location.value = property.location;
    var dialog = Get.dialog(
      PropertyDialog(
        isEditing: true,
        nameController: propertyNameController,
        color: color,
        onChangedColor: (MyColors? color) {
          this.color.value = color!;
        },
        onSelectLocation: (location) {
          this.location.value = location;
        },
        selectedLocation: location.value,
        onSave: () async {
          final newProperty = property.copyWith(
            name: propertyNameController.text,
            color: color.value,
            location: location.value,
          );
          var result = await _propertyRepository.save(
            entity: newProperty,
            idc: _authService.getUid(),
          );
          if (result != null) {
            _mySnackbar.snackSuccess('Property saved');
          } else {
            _mySnackbar.snackError('Error saving property');
          }
        },
        onDelete: () {
          _propertyRepository.deleteById(
              id: property.id, idc: _authService.getUid());
          Get.back();
        },
      ),
    );
    dialog.then((value) {
      _clear();
    });
  }

  Future<InversorNow> getInversorNow({required String id}) async {
    return await _inversorNowRepository.findById(
          id: id,
          idc: _authService.getUid(),
        ) ??
        InversorNow.defaultConstructor();
  }

  void _clear() {
    propertyNameController.clear();
    color.value = MyColors.PRIMARY;
    location.value = Pair(40.4176833585554, -3.7038147983551027);
  }
}
