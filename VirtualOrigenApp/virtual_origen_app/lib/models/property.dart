import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:virtual_origen_app/models/pair.dart';
import 'package:virtual_origen_app/services/localities/interface_locaties.dart';
import 'package:virtual_origen_app/themes/colors.dart';

class Property {
  final String id;
  final String name;
  final MyColors color;
  final Pair<double, double> location;
  final Map<String, String> guests;

  Property({
    String? id,
    required this.name,
    required this.color,
    required this.location,
    Map<String, String>? guests,
  })  : id = id ?? const Uuid().v4(),
        guests = guests ?? {};

  Future<String> get locationFormatter async =>
      await Get.find<ILocaties>().getLocalityName(location.key, location.value);

  Property copyWith({
    String? name,
    MyColors? color,
    Pair<double, double>? location,
  }) {
    return Property(
      id: id,
      name: name ?? this.name,
      color: color ?? this.color,
      location: location ?? this.location,
      guests: guests,
    );
  }

  Property.defaultConstructor()
      : id = const Uuid().v4(),
        name = '',
        color = MyColors.PURPLE,
        location = Pair(0, 0),
        guests = {};
}
