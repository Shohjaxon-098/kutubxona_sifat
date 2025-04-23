import '../../domain/entities/upload_image_response_entity.dart';

class UploadImageResponseModel extends UploadImageResponseEntity {
  UploadImageResponseModel({required String id}) : super(id: id);

  factory UploadImageResponseModel.fromJson(Map<String, dynamic> json) {
    return UploadImageResponseModel(id: json['id'].toString());
  }
}
