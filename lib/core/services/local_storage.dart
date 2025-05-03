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

  static Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _box.put('access_token', accessToken);
    await _box.put('refresh_token', refreshToken);
  }

  static Future<String?> getAccessToken() async {
    return _box.get('access_token');
  }

  static Future<String?> getRefreshToken() async {
    return _box.get('refresh_token');
  }

  static Future<void> clearTokens() async {
    await _box.delete('access_token');
    await _box.delete('refresh_token');
  }
}
