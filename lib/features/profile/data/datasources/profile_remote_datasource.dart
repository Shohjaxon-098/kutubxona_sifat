import 'package:kutubxona/core/constants/app_config.dart';
import 'package:kutubxona/core/core_exports.dart';
import 'package:kutubxona/core/error/exeptions.dart';
import 'package:kutubxona/features/profile/data/model/update_profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<void> updateProfile(UpdateProfileModel model);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final  dio=DioClient().dio;
  ProfileRemoteDataSourceImpl();

  @override
  Future<void> updateProfile(UpdateProfileModel model) async {
    final token = await LocalStorage.getAccessToken();

    FormData formData = FormData.fromMap(model.toJson());

    if (model.imagePath != null) {
      formData.files.add(MapEntry(
        'photo',
        await MultipartFile.fromFile(model.imagePath!, filename: 'profile.jpg'),
      ));
    }

    if (model.documentPath != null) {
      formData.files.add(MapEntry(
        'document',
        await MultipartFile.fromFile(model.documentPath!, filename: 'doc.jpg'),
      ));
    }

    final response = await dio.put(
      '${AppConfig.baseUrl}/account/profile/${AppConfig.libraryId}/',
      data: formData,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    if (response.statusCode != 200) {
      throw ServerException(message: "Xatolik yuz berdi.");
    }
  }
}
