part of 'upload_image_bloc.dart';

abstract class UploadImageEvent extends Equatable {
  const UploadImageEvent();

  @override
  List<Object> get props => [];
}

class StartUploadImage extends UploadImageEvent {
  final File file;
  final bool isFront;
  final String? type;

  const StartUploadImage(this.file, {required this.isFront,this.type} );

  @override
  List<Object> get props => [file, isFront];
}
