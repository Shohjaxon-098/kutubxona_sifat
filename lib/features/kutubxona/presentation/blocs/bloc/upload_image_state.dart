import 'package:kutubxona/features/kutubxona/domain/entities/upload_image_entity.dart';

abstract class UploadMediaState {}

class UploadMediaInitial extends UploadMediaState {}

class UploadMediaLoading extends UploadMediaState {}

class UploadMediaSuccess extends UploadMediaState {
  final MediaUpload media;

  UploadMediaSuccess(this.media);
}

class UploadMediaFailure extends UploadMediaState {
  final String message;

  UploadMediaFailure(this.message);
}
