abstract class ILocalStorage {
  void saveData(String key, dynamic value);
  T? getData<T>(String key, {T? defaultValue});
  void deleteData(String key);
}
