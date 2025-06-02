import 'package:hive/hive.dart';

class LocalStorage {
  static final _box = Hive.box("userBox");

  static Future<void> savePhone(String phone) async {
    await _box.put("phone", phone);
  }

  static String? get getPhone {
    return _box.get("phone");
  }

  static Future<void> saveUserId(int userId) async {
    await _box.put("user_id", userId);
  }

  static Future<int?> getUserId() async {
    return _box.get("user_id");
  }

  static Future<void> saveLibraryId(String id) async {
    await _box.put("id", id);
  }

  static String? get libraryId {
    return _box.get("id");
  }

  static Future<void> saveSlug(String slug) async {
    await _box.put("slug", slug);
  }

  static String? get slug {
    return _box.get("slug");
  }

  static String? getAccessToken() => _box.get('access_token');
  static String? getRefreshToken() => _box.get('refresh_token');

  static Future<void> saveAccessToken(String token) async =>
      _box.put('access_token', token);
  static Future<void> saveRefreshToken(String token) async =>
      _box.put('refresh_token', token);

  static Future<void> clearTokens() async {
    await _box.delete('access_token');
    await _box.delete('refresh_token');
  }

  static Future<void> setIsRegistered(bool value) async {
    await _box.put('isRegistered', value);
  }

  static bool get isRegistered {
    return _box.get('isRegistered', defaultValue: false);
  }

  static Future<void> saveUserData(Map<String, dynamic> userData) async {
    await _box.put('userData', userData);
  }

  static Map<String, dynamic>? get userData {
    return _box.get('userData');
  }

  static Future<void> clearUser() async {
    await _box.delete('isRegistered');
    await _box.delete('userData');
  }
}
