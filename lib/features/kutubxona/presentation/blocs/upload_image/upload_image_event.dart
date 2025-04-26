part of 'upload_image_bloc.dart';

abstract class UploadImageEvent extends Equatable {
  const UploadImageEvent();

  @override
  List<Object> get props => [];
}

class StartUploadImage extends UploadImageEvent {
  final File file;
  final bool isFront;

  const StartUploadImage(this.file, {required this.isFront});

  @override
  List<Object> get props => [file, isFront];
}
