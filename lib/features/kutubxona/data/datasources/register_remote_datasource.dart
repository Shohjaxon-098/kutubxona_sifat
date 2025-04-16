import 'package:dio/dio.dart';
import 'package:kutubxona/features/kutubxona/data/models/register_step1.dart';
import 'package:kutubxona/service/base_url.dart';

abstract class RegisterRemoteDataSource {
  Future<void> registerPhone(RegisterStep1Model model);
}

class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
  final Dio dio;

  RegisterRemoteDataSourceImpl({required this.dio});

  @override
  Future<void> registerPhone(RegisterStep1Model model) async {
    await dio.post(
      "$baseUrl/account/register/step1/", // 🔁 Bu yerga API endpoint URL qo‘ying
      data: model.toJson(),
    );
  }
}
