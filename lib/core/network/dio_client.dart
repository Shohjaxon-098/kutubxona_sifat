import 'package:kutubxona/export.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late final Dio dio;

  factory DioClient() {
    return _instance;
  }

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 30),
        responseType: ResponseType.json,
        contentType: 'application/json',
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await LocalStorage.getAccessToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },

        onError: (DioException error, handler) async {
          if (error.response?.statusCode == 401) {
            final refreshed = await _refreshToken();
            if (refreshed != null) {
              final retryRequest = error.requestOptions;
              retryRequest.headers['Authorization'] = 'Bearer $refreshed';

              final cloneResponse = await dio.fetch(retryRequest);
              return handler.resolve(cloneResponse);
            } else {
              await LocalStorage.clearTokens();
            }
          }

          return handler.next(error);
        },
      ),
    );
  }
  Future<String?> _refreshToken() async {
    try {
      final refreshToken = await LocalStorage.getRefreshToken();

      if (refreshToken == null) return null;

      final response = await dio.post(
        '/account/token/refresh/',
        data: {'refresh': refreshToken},
      );

      final newAccessToken = response.data['access'];
      await LocalStorage.saveAccessToken(newAccessToken);
      return newAccessToken;
    } catch (e) {
      await LocalStorage.clearTokens();
      return null;
    }
  }
}
