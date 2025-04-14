import 'package:hive/hive.dart';

class LocalStorage {
  static final _box = Hive.box('userBox');
  static const _phone = 'phone';
  static Future<void> saveUserData(Map<String, dynamic> userData) async {
    await _box.put('userData', userData);
  }

  static Future<Map<String, dynamic>?> getUserData() async {
    final data = _box.get('userData');
    if (data != null && data is Map) {
      return Map<String, dynamic>.from(data); // ✅ Bu joy muhim
    }
    return null;
  }

  static Future<String?> getPhone() async {
    return _box.get(_phone);
  }

  static Future<void> clearUserData() async {
    await _box.delete('userData');
  }
}
