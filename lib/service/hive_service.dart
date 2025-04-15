import 'package:hive/hive.dart';

class LocalStorage {
  static final _box = Hive.box("userBox");

  static Future<void> savePhone(String phone) async {
    await _box.put("phone", phone);
  }

  static Future<String?> getPhone() async {
    return _box.get("phone");
  }

  static Future<void> saveLibraryId(String id) async {
    await _box.put("library_id", id);
  }

  static Future<String?> getLibraryId() async {
    return _box.get("library_id");
  }
}
