import 'package:virtual_origen_app/models/permisionss.dart';

class Invitation {
  final String fromId;
  final String toId;
  final String propertyId;
  final bool state;
  final Permissionss permission;

  Invitation({
    required this.fromId,
    required this.toId,
    required this.propertyId,
    required this.state,
    required this.permission,
  });
}
