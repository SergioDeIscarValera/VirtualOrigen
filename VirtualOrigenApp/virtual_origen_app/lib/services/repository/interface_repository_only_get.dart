abstract class IRepositoryOnlyGet<T, ID, IDC> {
  Future<List<T>> findAll({required IDC idc});
  Future<T?> findById({required ID id, required IDC idc});
  Future<bool> existsById({required ID id, required IDC idc});
}
