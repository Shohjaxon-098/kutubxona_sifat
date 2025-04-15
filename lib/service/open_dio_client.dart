import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kutubxona/service/base_url.dart';
import 'package:kutubxona/service/dio_exeption.dart';

class ApiClient {
  ApiClient() {
    _init();
  }

  late Dio dio;
  late String errorData = '';
  _init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(seconds: 25),
        receiveTimeout: Duration(seconds: 20),
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) {
          switch (error.type) {
            case DioExceptionType.connectionTimeout:
            case DioExceptionType.sendTimeout:
              throw DeadlineExceededException(error.requestOptions);
            case DioExceptionType.receiveTimeout:
              throw ReceiveTimeOutException(error.requestOptions);
            case DioExceptionType.badResponse:
              switch (error.response?.statusCode) {
                case 401:
                  throw UnauthorizedException(error.requestOptions);
                case 404:
                  throw NotFoundException(error.requestOptions);
                case 409:
                  throw ConflictException(error.requestOptions);
                case 500:
                case 501:
                case 503:
                  throw InternalServerErrorException(error.requestOptions);
              }
              break;
            case DioExceptionType.cancel:
              break;
            case DioExceptionType.unknown:
              throw NoInternetConnectionException(error.requestOptions);
            default:
              debugPrint('Error Status Code: ${error.response?.statusCode}');

              return handler.next(error);
          }
          debugPrint('Error: ${error.response?.data}');
          errorData = error.response?.data;
          return handler.next(error);
        },
        onRequest: (requestOptions, handler) {
          String currentLocale = "uz";
          requestOptions.headers["Accept"] = "application/json";
          requestOptions.headers["Accept-Language"] =
              currentLocale.isEmpty ? "ru" : currentLocale;
          return handler.next(requestOptions);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          return handler.next(response);
        },
      ),
    );
  }
}
