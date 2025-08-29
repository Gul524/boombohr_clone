import 'package:get_storage/get_storage.dart';

class StorageService {
  static late GetStorage _box;

  static Future<void> init() async {
    await GetStorage.init('bamboo_forms_box');
    _box = GetStorage('bamboo_forms_box');
    if (_box.read('forms') == null) {
      await _box.write('forms', []);
    }
    if (_box.read('responses') == null) {
      await _box.write('responses', []);
    }
    if (_box.read('templates') == null) {
      await _box.write('templates', []);
    }
  }

  static T? read<T>(String key) => _box.read<T>(key);
  static Future<void> write(String key, dynamic value) => _box.write(key, value);
  static Future<void> remove(String key) => _box.remove(key);
  static Future<void> clear() => _box.erase();
}
