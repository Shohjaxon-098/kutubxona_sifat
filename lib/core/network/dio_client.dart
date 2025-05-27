import 'package:kutubxona/core/network/auth_interceptor.dart';
import 'package:kutubxona/export.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late final Dio dio;

  factory DioClient() {
    return _instance;
  }

  DioClient._internal() {
    dio = Dio(BaseOptions(baseUrl: AppConfig.baseUrl));
    dio.interceptors.add(AuthInterceptor(dio));
  }
}
