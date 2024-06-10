import 'package:virtual_origen_app/services/repository/interface_repository_only_get.dart';

abstract class IListenerRepositoryOnlyGet<T, ID, IDC>
    implements IRepositoryOnlyGet<T, ID, IDC> {
  void addListener({required IDC idc, required Function(List<T>) listener});
  void removeListener({required IDC idc});
  void addSingleListener(
      {required ID id, required IDC idc, required Function(T?) listener});
  void removeSingleListener({required ID id, required IDC idc});
}
