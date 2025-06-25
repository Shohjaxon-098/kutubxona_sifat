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
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 30),
        responseType: ResponseType.json,
        contentType: 'application/json',
      ),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final accessToken = await LocalStorage.getAccessToken();
          options.headers['Accept'] = 'application/json';
          options.headers['Authorization'] = 'Bearer $accessToken';
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401 &&
              !(error.requestOptions.extra['retry'] == true)) {
            final newAccessToken = await refreshToken();
            if (newAccessToken != null) {
              final options = error.requestOptions;
              options.headers['Authorization'] = 'Bearer $newAccessToken';
              options.extra['retry'] = true; // retry flag
              return handler.resolve(await dio.fetch(options));
            }
          }
          return handler.next(error);
        },
      ),
    );
  }
  Future<String?> refreshToken() async {
    try {
      final refreshToken = await LocalStorage.getRefreshToken();
      final response = await dio.post(
        'account/token/refresh/',
        data: {'refresh': refreshToken},
      );
      print(response.data['access']);
      final newAccessToken = response.data['access'];
      await LocalStorage.saveAccessToken(newAccessToken);
      return newAccessToken;
    } catch (e) {
      await LocalStorage.clearTokens();
      return null;
    }
  }
}
