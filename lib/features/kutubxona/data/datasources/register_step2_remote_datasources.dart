// lib/features/register_step2/data/datasources/register_step2_remote_data_source.dart

import 'package:kutubxona/core/util/important.dart';

abstract class RegisterStep2RemoteDataSource {
  Future<void> submitRegisterStep2(RegisterStep2Model model);
}

class RegisterStep2RemoteDataSourceImpl
    implements RegisterStep2RemoteDataSource {
  final Dio dio;

  RegisterStep2RemoteDataSourceImpl({required this.dio});

  @override
  Future<void> submitRegisterStep2(RegisterStep2Model model) async {
    final formData = model.toFormData();
    final response = await dio.post(
      '$baseUrl/account/register/step2/',
      data: formData,
    );

    if (response.statusCode != 201) {
      throw Exception('Server error: ${response.data}');
    }
  }
}
