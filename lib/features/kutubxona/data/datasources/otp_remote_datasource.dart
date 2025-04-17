// data/datasources/otp_remote_datasource.dart
import 'package:dio/dio.dart';
import 'package:kutubxona/features/kutubxona/data/models/register_verify.dart';
import 'package:kutubxona/service/base_url.dart';

abstract class OtpRemoteDataSource  {
  Future<void> verifyOtp(OtpVerifyModel model);
}

class OtpRemoteDataSourceImpl implements OtpRemoteDataSource {
  final Dio dio;

  OtpRemoteDataSourceImpl({required this.dio});

  @override
  Future<void> verifyOtp(OtpVerifyModel model) async {
    await dio.post(
      '$baseUrl/account/register/verify/',
      data: model.toJson(),
      options: Options(headers: {'Content-Type': 'application/json'}),
    );
  }
}
