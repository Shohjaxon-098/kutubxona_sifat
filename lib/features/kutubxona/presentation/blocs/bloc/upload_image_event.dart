part of 'upload_image_bloc.dart';

abstract class UploadImageEvent extends Equatable {
  const UploadImageEvent();

  @override
  List<Object?> get props => [];
}

class StartUploadImage extends UploadImageEvent {
  final File file;

  const StartUploadImage(this.file);

  @override
  List<Object?> get props => [file];
}
