import 'package:dio/dio.dart';
import 'package:kutubxona/core/constants/app_config.dart';
import 'package:kutubxona/core/core_exports.dart';
import 'package:kutubxona/features/profile/data/model/edit_profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<void> updateProfile(UpdateProfileModel model);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final dio = DioClient().dio;

  ProfileRemoteDataSourceImpl();

  @override
  Future<void> updateProfile(UpdateProfileModel model) async {
    final token = await LocalStorage.getAccessToken();
    try {
      await dio.put(
        '${AppConfig.baseUrl}/account/profile/${AppConfig.libraryId}/',
        data: model.toJson(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
    } on DioError catch (e) {
      // DioError turi bilan aniqlik kiritish
      final errorMessage = _handleDioError(e);
      debugPrint('Update Profile Error: $errorMessage');
      throw Exception(errorMessage);
    } catch (e) {
      // Har qanday boshqa xatoliklar
      debugPrint('Unexpected Error: $e');
      throw Exception('Nomaʼlum xatolik yuz berdi');
    }
  }

  String _handleDioError(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout) {
      return 'Ulanish vaqti tugadi';
    } else if (error.type == DioExceptionType.receiveTimeout) {
      return 'Serverdan javob olish vaqti tugadi';
    } else if (error.type == DioExceptionType.sendTimeout) {
      return 'So‘rov yuborish vaqti tugadi';
    } else if (error.type == DioExceptionType.badResponse) {
      // Serverdan javob keldi, lekin xatolik bilan
      final statusCode = error.response?.statusCode;
      final responseData = error.response?.data;
      return 'Server xatosi: $statusCode\nXabar: ${responseData ?? 'nomaʼlum'}';
    } else if (error.type == DioExceptionType.cancel) {
      return 'So‘rov bekor qilindi';
    } else {
      return 'Internetga ulanmagan bo‘lishi mumkin yoki boshqa xatolik: ${error.message}';
    }
  }
}
