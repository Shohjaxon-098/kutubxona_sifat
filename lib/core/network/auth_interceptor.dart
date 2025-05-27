import 'package:dio/dio.dart';
import 'package:kutubxona/config/config_exports.dart';
import 'package:kutubxona/core/core_exports.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;

  AuthInterceptor(this.dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await LocalStorage.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 &&
        !err.requestOptions.path.contains('refresh')) {
      final refreshToken = await LocalStorage.getRefreshToken();

      if (refreshToken != null) {
        try {
          final response = await dio.post(
            '${AppConfig.baseUrl}/account/token/refresh/',
            data: {'refresh': refreshToken},
          );

          final newAccessToken = response.data['access'];
          await LocalStorage.saveAccessToken(newAccessToken);

          // So‘rovni qayta jo‘natamiz
          final options = err.requestOptions;
          options.headers['Authorization'] = 'Bearer $newAccessToken';

          // ❗️ Yangi Dio emas, eski interceptorlar ishlashi uchun `dio.fetch()` emas, `dio.request()` chaqilmasin
          final cloneReq = await dio.fetch(options);
          return handler.resolve(cloneReq);
        } catch (e) {
          // Refresh token ham tugagan – ammo siz logout qilishni xohlamayapsiz
          // Shunchaki xatoni uzatamiz
          return handler.reject(err);
        }
      }
    }

    return handler.next(err);
  }
}
