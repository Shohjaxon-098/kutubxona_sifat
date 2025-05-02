import 'package:kutubxona/core/util/important.dart';
import 'package:kutubxona/core/network/dio_client.dart';
import 'package:kutubxona/features/auth/data/model/login_model.dart';

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
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Muvaffaqiyatli login
      } else {
        throw Exception('Login failed');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final data = e.response!.data;
        if (data is Map<String, dynamic> &&
            data.containsKey('non_field_errors')) {
          throw Exception(
            data['non_field_errors'][0] == 'Invalid password'
                ? 'Noto`g`ri kod'
                : 'Foydalanuvchi topilmadi',
          );
        }
      }
      throw Exception('Login error');
    }
  }
}
