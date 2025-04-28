import 'package:kutubxona/core/network/dio_client.dart';
import 'package:kutubxona/features/kutubxona/data/models/login_model.dart';
import 'package:kutubxona/core/constants/app_config.dart';

abstract class LoginRemoteDaraSources {
  Future<void> login(LoginModel model);
}

class LoginRemoteDaraSourcesImpl implements LoginRemoteDaraSources {
  final dio = DioClient().dio;

  LoginRemoteDaraSourcesImpl();

  @override
  Future<void> login(LoginModel model) async {
    try {
      final response = await dio.post(
        "${AppConfig.baseUrl}/account/login/", // 🔁 Bu yerga API endpoint URL qo‘ying
        data: model.toJson(),
      );
      if (response.statusCode == 200) {
        return response.data;
      } else if (response.statusCode != 200) {
        throw Exception(response.data ?? 'Registration failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
