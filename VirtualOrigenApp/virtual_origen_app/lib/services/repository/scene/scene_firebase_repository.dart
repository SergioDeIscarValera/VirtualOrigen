import 'package:get/get.dart';
import 'package:virtual_origen_app/models/scene.dart';
import 'package:virtual_origen_app/models/smart_device.dart';
import 'package:virtual_origen_app/models/smart_device_type.dart';
import 'package:virtual_origen_app/services/repository/gen_firebase/gen_firebase_repository.dart';
import 'package:virtual_origen_app/services/repository/scene/interface_scene_repository.dart';
import 'package:virtual_origen_app/services/repository/smart_device/interface_smart_device_repository.dart';
import 'package:virtual_origen_app/themes/colors.dart';

class SceneFirebaseRepository extends GenFirebaseRepository<Scene, String>
    implements ISceneRepository {
  late ISmartDeviceRepository _smartDeviceRepository;

  SceneFirebaseRepository() {
    _smartDeviceRepository = Get.find<ISmartDeviceRepository>();
  }

  @override
  String get collectionName => "scene";

  @override
  Scene fromJson(Map<String, dynamic> json) {
    return Scene(
        id: json["id"],
        name: json["name"],
        color: MyColors.values
            .firstWhere((element) => element.token == json["color"]),
        type: SmartDeviceType.values
            .firstWhere((element) => element.token == json["type"]),
        devicesConfig: (json["devicesConfig"] as List<dynamic>)
            .map<SmartDevice>((e) => SmartDevice.fromJson(e))
            .toList());
  }

  @override
  String get idName => "id";

  @override
  String get listName => "scenes";

  @override
  Map<String, dynamic> toJson(Scene entity) {
    return {
      "id": entity.id,
      "name": entity.name,
      "color": entity.color.token,
      "type": entity.type.token,
      "devicesConfig": entity.devicesConfig.map((e) => e.toJson()).toList(),
    };
  }

  @override
  Future<void> applyScene({
    required String id,
    required String idc,
  }) async {
    final scene = await findById(id: id, idc: idc);
    if (scene == null) return;
    await _smartDeviceRepository.saveAll(
      entities: scene.devicesConfig,
      idc: idc,
    );
  }
}
