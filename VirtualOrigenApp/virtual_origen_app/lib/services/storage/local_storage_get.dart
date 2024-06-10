import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:virtual_origen_app/services/storage/interface_local_storage.dart';

class LocalStorageGet extends GetxService implements ILocalStorage {
  late GetStorage _box;
  @override
  void onInit() async {
    super.onInit();
    _box = GetStorage();
  }

  @override
  void deleteData(String key) {
    if (GetPlatform.isWeb) return;
    _box.remove(key);
  }

  @override
  T? getData<T>(String key, {T? defaultValue}) {
    if (GetPlatform.isWeb) return defaultValue;
    return _box.read<T?>(key);
  }

  @override
  void saveData(String key, value) {
    if (GetPlatform.isWeb) return;
    _box.write(key, value);
  }
}
