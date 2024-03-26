import 'package:virtual_origen_app/models/inversor_yesterday.dart';
import 'package:virtual_origen_app/services/repository/gen_firebase/gen_firebase_repository_only_get.dart';

class InversorYerserdayFirebaseRepository
    extends GenFirebaseRepositoryOnlyGet<InversorYerserday, String> {
  @override
  String get collectionName => "inversor_yesterday";

  @override
  String get idName => "dateTime";

  @override
  String get listName => "properties";

  @override
  InversorYerserday fromJson(Map<String, dynamic> json) {
    return InversorYerserday(
      propertyId: json["propertyId"],
      dateTime: DateTime.parse(json["dateTime"]),
      battery: json["battery"],
      consumption: json["consumption"],
      gain: json["gain"],
    );
  }

  @override
  Map<String, dynamic> toJson(InversorYerserday entity) {
    return {
      "propertyId": entity.propertyId,
      "dateTime": entity.dateTime.toString(),
      "battery": entity.battery,
      "consumption": entity.consumption,
      "gain": entity.gain,
    };
  }
}
