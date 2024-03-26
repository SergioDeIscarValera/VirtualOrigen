import 'package:virtual_origen_app/models/invitation.dart';
import 'package:virtual_origen_app/models/permisionss.dart';
import 'package:virtual_origen_app/services/repository/gen_firebase/gen_firebase_repository.dart';
import 'package:virtual_origen_app/services/repository/invitation/interface_invitation_repository.dart';

class InvitationFirebaseRepository
    extends GenFirebaseRepository<Invitation, String>
    implements IInvitationRepository {
  @override
  String get collectionName => "invitation";

  @override
  Invitation fromJson(Map<String, dynamic> json) {
    return Invitation(
      fromId: json["fromId"],
      toId: json["toId"],
      propertyId: json["propertyId"],
      state: json["state"],
      permission: Permissionss.values.firstWhere(
        (element) => element.token == json["permission"],
      ),
    );
  }

  @override
  String get idName => "id";

  @override
  String get listName => "properties";

  @override
  Map<String, dynamic> toJson(Invitation entity) {
    return {
      "fromId": entity.fromId,
      "toId": entity.toId,
      "propertyId": entity.propertyId,
      "state": entity.state,
      "permission": entity.permission.token,
    };
  }
}
