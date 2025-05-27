import 'package:dio/dio.dart';
import 'package:kutubxona/core/constants/app_config.dart';
import 'package:kutubxona/core/error/exeptions.dart';
import 'package:kutubxona/core/network/dio_client.dart';
import 'package:kutubxona/features/auth/data/model/register_step2.dart';

abstract class RegisterStep2RemoteDataSource {
  Future<void> submitRegisterStep2(RegisterStep2Model model);
}

class RegisterStep2RemoteDataSourceImpl
    implements RegisterStep2RemoteDataSource {
  final  dio=DioClient().dio;
  RegisterStep2RemoteDataSourceImpl();

  @override
  Future<void> submitRegisterStep2(RegisterStep2Model model) async {
    try {
      final response = await dio.post(
        '${AppConfig.baseUrl}/account/register/step2/',
        data: model.toJson(),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerException(message: 'Ro‘yxatdan o‘tishda xatolik.');
      }
    } on DioException catch (e) {
      // Serverdan kelgan aniq xatolikni olish
      final errorMessage =
          e.response?.data['message'] ?? 'Server xatolik yuz berdi';
      throw ServerException(message: errorMessage);
    } catch (e) {
      // Nomalum xatoliklar
      throw ServerException(message: 'Nomaʼlum xatolik: ${e.toString()}');
    }
  }
}
