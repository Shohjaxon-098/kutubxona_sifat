import 'package:kutubxona/core/util/important.dart';
import 'package:kutubxona/features/auth/data/model/upload_image_response_model.dart';

abstract class CommonRemoteDataSource {
  Future<UploadImageResponseModel> uploadImage(File file);
}

class CommonRemoteDataSourceImpl implements CommonRemoteDataSource {
  final Dio dio;
  CommonRemoteDataSourceImpl(this.dio);

  @override
  Future<UploadImageResponseModel> uploadImage(File file) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path),
        'type': 'image', // doim image
      });

      final response = await dio.post(
        '${AppConfig.baseUrl}/common/media/upload/',
        data: formData,
      );

      if (response.statusCode == 201) {
        return UploadImageResponseModel.fromJson(
          response.data,
        ); // API qaytargan ID
      } else {
        throw Exception('Rasmni yuklashda xatolik');
      }
    } catch (e) {
      throw Exception('Rasmni yuklashda xatolik: $e');
    }
  }
}
