import 'package:dio/dio.dart';
import 'package:kutubxona/service/base_url.dart';
import 'package:kutubxona/service/open_dio_client.dart';

class ApiService extends ApiClient {
  Future<Response> registerStep2(Map<String, dynamic> userData) async {
    try {
      return await dio.post('$baseUrl/account/register/step2/', data: userData);
    } catch (e) {
      rethrow;
    }
  }



  Future<Response> accountLibrary(
    Map<String, dynamic> userData,
    String domain,
  ) async {
    try {
      return await dio.get('$baseUrl/account/library/$domain', data: userData);
    } catch (e) {
      rethrow;
    }
  }
}
