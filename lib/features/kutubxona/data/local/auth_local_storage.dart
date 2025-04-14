import 'package:hive/hive.dart';

class AuthLocalStorage {
  static const _boxName = 'authBox';

  static Future<void> saveLibraryId(int id) async {
    final box = await Hive.openBox(_boxName);
    await box.put('library_id', id);
  }

  static Future<int?> getLibraryId() async {
    final box = await Hive.openBox(_boxName);
    return box.get('library_id');
  }

  static Future<void> clear() async {
    final box = await Hive.openBox(_boxName);
    await box.clear();
  }
}
