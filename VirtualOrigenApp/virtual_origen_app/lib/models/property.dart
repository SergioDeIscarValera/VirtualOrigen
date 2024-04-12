import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:virtual_origen_app/models/invitation_permission.dart';
import 'package:virtual_origen_app/models/pair.dart';
import 'package:virtual_origen_app/services/localities/interface_locaties.dart';
import 'package:virtual_origen_app/themes/colors.dart';

class Property {
  final String id;
  final String name;
  final MyColors color;
  final Pair<double, double> location;
  final List<PropertyGuest> guests;

  Property({
    String? id,
    required this.name,
    required this.color,
    required this.location,
    List<PropertyGuest>? guests,
  })  : id = id ?? const Uuid().v4(),
        guests = guests ?? [];

  Future<String> get locationFormatter async =>
      await Get.find<ILocaties>().getLocalityName(location.key, location.value);

  Property copyWith({
    String? name,
    MyColors? color,
    Pair<double, double>? location,
    List<PropertyGuest>? guests,
  }) {
    return Property(
      id: id,
      name: name ?? this.name,
      color: color ?? this.color,
      location: location ?? this.location,
      guests: guests ?? this.guests,
    );
  }

  Property.defaultConstructor()
      : id = const Uuid().v4(),
        name = '',
        color = MyColors.PURPLE,
        location = Pair(0, 0),
        guests = [];

  InvitationPermission? getPermission(String email) {
    var guest =
        guests.firstWhereOrNull((element) => element.guestEmail == email);
    return guest?.permission;
  }
}

class PropertyGuest {
  final String guestEmail;
  final InvitationPermission permission;
  final String guestProfileImage;
  final int state; // 0: pending, 1: accepted, 2: rejected

  PropertyGuest({
    required this.guestEmail,
    required this.permission,
    required this.guestProfileImage,
    this.state = 0,
  });

  PropertyGuest copyWith({
    String? guestEmail,
    InvitationPermission? permission,
    String? guestProfileImage,
    int? state,
  }) {
    return PropertyGuest(
      guestEmail: guestEmail ?? this.guestEmail,
      permission: permission ?? this.permission,
      guestProfileImage: guestProfileImage ?? this.guestProfileImage,
      state: state ?? this.state,
    );
  }

  PropertyGuest.fromJson(Map<String, dynamic> json)
      : guestEmail = json['guestEmail'],
        permission = InvitationPermission.values
            .firstWhere((element) => element.token == json['permission']),
        guestProfileImage = json['guestProfileImage'],
        state = json['state'];

  Map<String, dynamic> toJson() {
    return {
      'guestEmail': guestEmail,
      'permission': permission.token,
      'guestProfileImage': guestProfileImage,
      'state': state,
    };
  }
}
