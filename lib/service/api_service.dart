import 'package:dio/dio.dart';
import 'package:kutubxona/features/kutubxona/data/models/register_step1.dart';

import 'package:kutubxona/features/kutubxona/data/models/register_verify.dart';
import 'package:kutubxona/service/base_url.dart';
import 'package:kutubxona/service/open_dio_client.dart';

class ApiService extends ApiClient {
  Future<Response> registerStep1(RegisterStep1 userData) async {
    try {
      return await dio.post(
        '$baseUrl/account/register/step1/',
        data: userData.toJson(),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> registerStep2(Map<String, dynamic> userData) async {
    try {
      return await dio.post('$baseUrl/account/register/step2/', data: userData);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> registerVerify(RegisterVerifyModel userData) async {
    try {
      final data = userData.toJson();
      print("Sending OTP verify data: $data");
      final response = await dio.post(
        '$baseUrl/account/register/verify/',
        data: data,
      );
      print("✅ Verified OTP: ${response.data}");
      return response;
    } catch (e) {
      print("❌ OTP verify error: $e");
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
