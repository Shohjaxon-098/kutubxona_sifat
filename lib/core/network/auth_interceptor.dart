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
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 &&
        !err.requestOptions.path.contains(
          '${AppConfig.baseUrl}/token/refresh',
        )) {
      final refreshToken = LocalStorage.getRefreshToken();

      if (refreshToken != null) {
        try {
          final response = await dio.post(
            '${AppConfig.baseUrl}/account/token/refresh/',
            data: {'refresh': refreshToken},
          );
          print('New access token: ${response.data['access']}');

          final newAccessToken = response.data['access'];
          await LocalStorage.saveAccessToken(newAccessToken);

          if (response.data.containsKey('refresh')) {
            final newRefreshToken = response.data['refresh'];
            await LocalStorage.saveRefreshToken(newRefreshToken);
          }

          final options = err.requestOptions;
          options.headers['Authorization'] = 'Bearer $newAccessToken';

          final clonedResponse = await dio.request(
            options.path,
            data: options.data,
            queryParameters: options.queryParameters,
            options: Options(method: options.method, headers: options.headers),
          );

          return handler.resolve(clonedResponse);
        } catch (e) {
          await LocalStorage.clearTokens(); // optional
          return handler.reject(err);
        }
      }
    }

    return handler.next(err);
  }
}
