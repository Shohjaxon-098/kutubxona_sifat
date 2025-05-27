// data/datasources/otp_remote_datasource.dart

import 'package:kutubxona/export.dart';

abstract class OtpRemoteDataSource {
  Future<void> verifyOtp(OtpVerifyModel model);
}

class OtpRemoteDataSourceImpl implements OtpRemoteDataSource {
  final  dio=DioClient().dio;
  OtpRemoteDataSourceImpl();

  @override
  Future<void> verifyOtp(OtpVerifyModel model) async {
    final response = await dio.post(
      '${AppConfig.baseUrl}/account/register/verify/',
      data: model.toJson(),
      options: Options(headers: {'Content-Type': 'application/json'}),
    );
    if (response.statusCode == 200) {
      final userId = response.data['user_id'];
      await LocalStorage.saveUserId(userId);
    } else {
      throw Exception(response.data);
    }
  }
}
