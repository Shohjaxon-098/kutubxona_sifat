import 'package:kutubxona/core/constants/app_config.dart';
import 'package:kutubxona/core/core_exports.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;

  AuthInterceptor(this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = LocalStorage.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final isUnauthorized = err.response?.statusCode == 401;
    final isNotRefreshCall =
        !err.requestOptions.path.contains('/token/refresh');

    if (isUnauthorized && isNotRefreshCall) {
      final refreshToken = await LocalStorage.getRefreshToken();

      if (refreshToken != null) {
        try {
          // Token refresh qilish
          final response = await dio.post(
            '${AppConfig.baseUrl}/account/token/refresh/',
            data: {'refresh': refreshToken},
          );

          final newAccessToken = response.data['access'];
          await LocalStorage.saveAccessToken(newAccessToken);

          if (response.data.containsKey('refresh')) {
            await LocalStorage.saveRefreshToken(response.data['refresh']);
          }

          // Avvalgi requestni qayta yuborish
          final requestOptions = err.requestOptions;
          requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

          final newResponse = await dio.request(
            requestOptions.path,
            data: requestOptions.data,
            queryParameters: requestOptions.queryParameters,
            options: Options(
              method: requestOptions.method,
              headers: requestOptions.headers,
            ),
          );

          return handler.resolve(newResponse);
        } catch (e) {
          await LocalStorage.clearTokens(); // logout logikasini shu yerda bajaring
          return handler.reject(err); // asl xatoni qaytaramiz
        }
      }
    }

    // boshqa xatolarni davom ettiramiz
    return handler.next(err);
  }
}
