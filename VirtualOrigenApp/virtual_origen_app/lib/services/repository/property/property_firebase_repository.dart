import 'package:virtual_origen_app/models/pair.dart';
import 'package:virtual_origen_app/models/property.dart';
import 'package:virtual_origen_app/services/repository/gen_firebase/gen_firebase_repository.dart';
import 'package:virtual_origen_app/services/repository/property/interface_property_repository.dart';
import 'package:virtual_origen_app/themes/colors.dart';

class PropertyFirebaseRepository extends GenFirebaseRepository<Property, String>
    implements IPropertyRepository {
  @override
  String get collectionName => "property";

  @override
  Property fromJson(Map<String, dynamic> json) {
    return Property(
      id: json["id"],
      name: json["name"],
      color: MyColors.values
          .firstWhere((element) => element.token == json["color"]),
      location: Pair.doubleFromString(json["location"]),
      guests: (json["guests"] as List)
          .map((e) => PropertyGuest.fromJson(e))
          .toList(),
    );
  }

  @override
  String get idName => "id";

  @override
  String get listName => "properties";

  @override
  Map<String, dynamic> toJson(Property entity) {
    return {
      "id": entity.id,
      "name": entity.name,
      "color": entity.color.token,
      "location": entity.location.toString(),
      "guests": entity.guests.map((e) => e.toJson()).toList(),
    };
  }
}
