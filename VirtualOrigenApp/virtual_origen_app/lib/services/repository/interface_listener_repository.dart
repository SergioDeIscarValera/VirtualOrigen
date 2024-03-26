import 'package:virtual_origen_app/services/repository/interface_repository.dart';

abstract class IListenerRepository<T, ID, IDC>
    implements IRepository<T, ID, IDC> {
  void addListener({required IDC idc, required Function(List<T>) listener});
  void removeListener({required IDC idc});
}
