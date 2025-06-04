import 'package:dio/dio.dart';
import 'package:kutubxona/core/error/exeptions.dart';
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
    try {
      final response = await dio.post(
        "${AppConfig.baseUrl}/account/register/step1/",
        data: model.toJson(),
      );

      if (response.statusCode != 201) {
        final message =
            response.data['message'] ?? 'Ro‘yxatdan o‘tishda xatolik yuz berdi';
        throw Exception('API Error: $message');
      }
    } on DioException catch (e) {
      // Xatolikni batafsil tekshirish
      if (e.response != null) {
        final data = e.response!.data;
        if (data is Map<String, dynamic>) {
          if (data.containsKey('non_field_errors')) {
            final nonFieldErrors = data['non_field_errors'];
            if (nonFieldErrors is List && nonFieldErrors.isNotEmpty) {
              final errorText = nonFieldErrors[0];
              if (errorText ==
                  'User with this phone number already exists in the library.') {
                throw ServerException(
                  message:
                      'Ushbu telefon raqami bilan foydalanuvchi allaqachon mavjud',
                );
              } else {
                throw Exception(errorText);
              }
            }
          }
          // Agar boshqa "message" yoki "detail" maydonlari bo‘lsa
          if (data.containsKey('message')) {
            throw Exception(data['message']);
          }
          if (data.containsKey('detail')) {
            throw Exception(data['detail']);
          }
        }
      }
      // Default xatolik xabari
      throw Exception('Internet yoki server bilan bog‘liq muammo');
    } catch (e) {
      throw Exception('Noma’lum xatolik: ${e.toString()}');
    }
  }
}
