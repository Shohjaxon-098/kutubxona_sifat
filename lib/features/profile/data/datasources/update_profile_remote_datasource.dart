import 'package:kutubxona/core/constants/app_config.dart';
import 'package:kutubxona/core/core_exports.dart';
import 'package:kutubxona/features/profile/data/model/update_profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<void> updateProfile(String libraryId, UpdateProfileModel model);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final dio = DioClient().dio;

  ProfileRemoteDataSourceImpl();

  @override
  Future<void> updateProfile(String libraryId, UpdateProfileModel model) async {
    await dio.put(
      '${AppConfig.baseUrl}/account/profile/$libraryId/',
      data: model.toJson(),
    );
  }
}
