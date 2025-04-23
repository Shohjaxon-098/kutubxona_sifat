import 'dart:io';

abstract class UploadMediaEvent {}

class UploadMediaStarted extends UploadMediaEvent {
  final File file;
  final String type;

  UploadMediaStarted({required this.file, required this.type});
}
