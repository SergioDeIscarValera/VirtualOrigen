import 'package:virtual_origen_app/models/scene.dart';
import 'package:virtual_origen_app/services/repository/interface_listener_repository.dart';

abstract class ISceneRepository
    implements IListenerRepository<Scene, String, String> {
  Future<void> applyScene({
    required String id,
    required String idc,
  });
}
