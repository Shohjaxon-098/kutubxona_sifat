part of 'upload_image_bloc.dart';

abstract class UploadImageState extends Equatable {
  const UploadImageState();

  @override
  List<Object?> get props => [];
}

class UploadImageInitial extends UploadImageState {}

class UploadImageLoading extends UploadImageState {}

class UploadImageSuccess extends UploadImageState {
  final int id;
  final File file;

  const UploadImageSuccess(this.id, this.file);

  @override
  List<Object?> get props => [id, file];
}

class UploadImageFailure extends UploadImageState {
  final String message;

  const UploadImageFailure(this.message);

  @override
  List<Object?> get props => [message];
}
