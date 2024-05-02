import 'package:virtual_origen_app/models/smart_device.dart';
import 'package:virtual_origen_app/services/repository/gen_firebase/gen_firebase_repository.dart';
import 'package:virtual_origen_app/services/repository/smart_device/interface_smart_device_repository.dart';

class SmartDeviceFirebaseRepository
    extends GenFirebaseRepository<SmartDevice, String>
    implements ISmartDeviceRepository {
  @override
  String get collectionName => "smart_device";

  @override
  SmartDevice fromJson(Map<String, dynamic> json) {
    // return SmartDevice(
    //   id: json["id"],
    //   name: json["name"],
    //   type: SmartDeviceType.values
    //       .firstWhere((element) => element.token == json["type"]),
    //   color: MyColors.values
    //       .firstWhere((element) => element.token == json["color"]),
    //   timeZones: json["timeZones"]
    //       .map<DateTimeRange>((e) => DateTimeRange(
    //             start: DateTime.parse(e.split(" -")[0]),
    //             end: DateTime.parse(e.split("- ")[1]),
    //           ))
    //       .toList(),
    //   days: (json['days'] as List<dynamic>).cast<bool>(),
    //   batteryRange: json.containsKey("batteryRange")
    //       ? Pair.intFromString(json["batteryRange"])
    //       : null,
    //   productionRange: json.containsKey("productionRange")
    //       ? Pair.intFromString(json["productionRange"])
    //       : null,
    //   consumptionRange: json.containsKey("consumptionRange")
    //       ? Pair.intFromString(json["consumptionRange"])
    //       : null,
    //   temperatureRange: json.containsKey("temperatureRange")
    //       ? Pair.intFromString(json["temperatureRange"])
    //       : null,
    //   rainRange: json.containsKey("rainRange")
    //       ? Pair.intFromString(json["rainRange"])
    //       : null,
    //   isManualMode:
    //       json.containsKey("isManualMode") ? json["isManualMode"] : false,
    //   isOn: json["isOn"],
    // );
    return SmartDevice.fromJson(json);
  }

  @override
  String get idName => "id";

  @override
  String get listName => "smart_devices";

  @override
  Map<String, dynamic> toJson(SmartDevice entity) => entity.toJson();
}
