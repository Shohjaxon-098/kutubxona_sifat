import 'package:kutubxona/core/error/exeptions.dart';
import 'package:kutubxona/export.dart';
import 'package:dio/dio.dart';

abstract class OtpRemoteDataSource {
  Future<void> verifyOtp(OtpVerifyModel model);
}

class OtpRemoteDataSourceImpl implements OtpRemoteDataSource {
  final dio = DioClient().dio;

  OtpRemoteDataSourceImpl();

  @override
  Future<void> verifyOtp(OtpVerifyModel model) async {
    try {
      final response = await dio.post(
        '${AppConfig.baseUrl}/account/register/verify/',
        data: model.toJson(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final userId = response.data['user_id'];
        await LocalStorage.saveUserId(userId);
      } else {
        // fallback
        throw Exception("Xatolik yuz berdi");
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data?['detail'] ?? e.message;

      if (errorMessage.toString().toLowerCase().contains("otp") ||
          errorMessage.toString().contains("Invalid OTP")) {
        throw ServerException(message: "Тасдиқлаш коди нотўғри");
      } else {
        throw Exception("Xatolik: $errorMessage");
      }
    }
  }
}
