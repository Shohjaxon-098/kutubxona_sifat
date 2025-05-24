import 'package:dio/dio.dart';
import 'package:kutubxona/core/constants/app_config.dart';
import 'auth_interceptor.dart';

class DioClient {
  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        contentType: 'application/json',
      ),
    );

    dio.interceptors.add(AuthInterceptor(dio));
    return dio;
  }
}
