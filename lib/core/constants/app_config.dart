import 'package:kutubxona/core/constants/important.dart';

class AppConfig {
  static const String baseUrl = 'https://library.sifatdev.uz/api/v1';
  static String? get libraryId {
    return LocalStorage.libraryId;
  }
    static String? get slug {
    return LocalStorage.slug;
  }
    static String? get getPhone {
    return LocalStorage.getPhone;
  }
}
