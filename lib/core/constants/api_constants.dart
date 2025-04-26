import 'package:kutubxona/core/constants/app_config.dart';

class ApiConstants {
  static String categories =
      '${AppConfig.baseUrl}/books/${AppConfig.libraryId.toString()}/categories/';
  static String books =
      '${AppConfig.baseUrl}/books/${AppConfig.libraryId.toString()}';
}
