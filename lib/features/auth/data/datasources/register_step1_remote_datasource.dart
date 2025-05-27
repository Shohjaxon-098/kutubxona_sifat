import 'package:dio/dio.dart';
import 'package:kutubxona/core/network/dio_client.dart';
import 'package:kutubxona/features/auth/data/model/register_step1.dart';
import 'package:kutubxona/core/constants/app_config.dart';

abstract class RegisterStep1RemoteDataSource {
  Future<void> registerPhone(RegisterStep1Model model);
}

class RegisterStep1RemoteDataSourceImpl
    implements RegisterStep1RemoteDataSource {
  final dio = DioClient().dio;
  RegisterStep1RemoteDataSourceImpl();

  @override
  Future<void> registerPhone(RegisterStep1Model model) async {
    final response = await dio.post(
      "${AppConfig.baseUrl}/account/register/step1/", // 🔁 Bu yerga API endpoint URL qo‘ying
      data: model.toJson(),
    );
    if (response.statusCode != 201) {
      throw Exception(response.data['message'] ?? 'Registration failed');
    }
  }
}
