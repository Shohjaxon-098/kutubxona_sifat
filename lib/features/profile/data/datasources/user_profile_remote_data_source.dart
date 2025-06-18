import 'package:kutubxona/core/error/exeptions.dart';
import 'package:kutubxona/core/network/dio_client.dart';
import 'package:kutubxona/core/services/local_storage.dart';
import 'package:kutubxona/features/profile/data/model/user_profile_model.dart';
import 'package:dio/dio.dart';
import 'package:kutubxona/config/config_exports.dart';
import 'package:kutubxona/features/profile/domain/entities/user_entity.dart';

abstract class UserProfileRemoteDataSource {
  Future<UserProfileEntity> getUserProfile();
}

class UserProfileRemoteDataSourceImpl implements UserProfileRemoteDataSource {
  final dio = DioClient().dio;
  UserProfileRemoteDataSourceImpl();
  @override
  Future<UserProfileModel> getUserProfile() async {
    final token = await LocalStorage.getAccessToken();
    try {
      final response = await dio.get(
        '${AppConfig.baseUrl}/account/profile/${AppConfig.libraryId}/',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      print(response.data);
      final data = response.data;

      return UserProfileModel.fromJson(data);
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data?['detail'] ??
          e.response?.data?['message'] ??
          e.message ??
          'Noma’lum xatolik yuz berdi';
      print(token);
      throw ServerException(message: errorMessage);
    }
  }
}
