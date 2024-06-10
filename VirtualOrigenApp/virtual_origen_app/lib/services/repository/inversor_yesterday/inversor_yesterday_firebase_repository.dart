import 'package:virtual_origen_app/models/inversor_yesterday.dart';
import 'package:virtual_origen_app/services/repository/gen_firebase/gen_firebase_repository_only_get.dart';

class InversorYerserdayFirebaseRepository
    extends GenFirebaseRepositoryOnlyGet<InversorYerserday, String> {
  @override
  String get collectionName => "inversor_yesterday";

  @override
  String get idName => "datetime";

  @override
  String get listName => "data";

  @override
  InversorYerserday fromJson(Map<String, dynamic> json) {
    return InversorYerserday(
      dateTime: DateTime.parse(json["datetime"].toString()),
      battery: double.parse(json["battery"].toString()),
      consumption: json["consumption"],
      gain: json["gain"],
    );
  }
}
