import 'dart:io';

import 'package:kutubxona/core/util/important.dart';
import 'package:kutubxona/features/kutubxona/domain/entities/upload_image_entity.dart';

class MediaRemoteDataSource {
  final Dio dio;

  MediaRemoteDataSource(this.dio);

  Future<MediaUpload> uploadMedia(File file, String type) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path),
      'type': type,
    });

    final response = await dio.post('${AppConfig.baseUrl}/common/media/upload/', data: formData);
    return MediaUpload.fromJson(response.data);
  }
}
