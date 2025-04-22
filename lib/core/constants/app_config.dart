import 'package:kutubxona/core/util/important.dart';

class AppConfig {
  static const String baseUrl = 'https://library.sifatdev.uz/api/v1';
  static String? get libraryId {
    return LocalStorage.libraryId;
  }
}
