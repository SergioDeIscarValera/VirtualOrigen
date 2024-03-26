import 'package:virtual_origen_app/models/invitation.dart';
import 'package:virtual_origen_app/services/repository/interface_listener_repository.dart';

abstract class IInvitationRepository
    implements IListenerRepository<Invitation, String, String> {}
