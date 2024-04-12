import 'package:virtual_origen_app/models/invitation.dart';
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
      fromEmail: json["fromEmail"],
      fromProfileImage: json["fromProfileImage"],
      ownerId: json["ownerId"],
      propertyId: json["propertyId"],
      propertyName: json["propertyName"],
      state: json["state"],
      isNew: json["isNew"],
    );
  }

  @override
  String get idName => "propertyId";

  @override
  String get listName => "invitatios";

  @override
  Map<String, dynamic> toJson(Invitation entity) {
    return {
      "fromEmail": entity.fromEmail,
      "fromProfileImage": entity.fromProfileImage,
      "ownerId": entity.ownerId,
      "propertyId": entity.propertyId,
      "propertyName": entity.propertyName,
      "state": entity.state,
      "isNew": entity.isNew,
    };
  }

  @override
  Future<bool> haveNewInvitations({required String idc}) async {
    return (await findAll(idc: idc)).any((element) => element.isNew);
  }
}
