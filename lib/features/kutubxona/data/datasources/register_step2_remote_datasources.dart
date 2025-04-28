import 'package:kutubxona/core/constants/important.dart';

abstract class RegisterStep2RemoteDataSource {
  Future<void> submitRegisterStep2(RegisterStep2Model model);
}

class RegisterStep2RemoteDataSourceImpl
    implements RegisterStep2RemoteDataSource {
  final Dio dio;

  RegisterStep2RemoteDataSourceImpl({required this.dio});

  @override
  Future<void> submitRegisterStep2(RegisterStep2Model model) async {
    try {
      final response = await dio.post(
        '${AppConfig.baseUrl}/account/register/step2/',
        data: model.toJson(),
      );
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
