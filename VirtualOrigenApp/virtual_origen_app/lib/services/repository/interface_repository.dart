import 'package:virtual_origen_app/services/repository/interface_repository_only_get.dart';

abstract class IRepository<T, ID, IDC> extends IRepositoryOnlyGet<T, ID, IDC> {
  Future<T?> save({required T entity, required IDC idc});
  Future<List<T>?> saveAll({required List<T> entities, required IDC idc});
  Future<void> deleteById({required ID id, required IDC idc});
  Future<void> deleteAllWhere({required List<ID> ids, required IDC idc});
  Future<void> deleteAll({required IDC idc});
}
