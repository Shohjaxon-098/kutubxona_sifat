import 'package:kutubxona/core/util/important.dart';

class MediaUpload {
  final int id;
  final File file;
  final String type;
  final int size;
  final String fileName;

  MediaUpload({
    required this.id,
    required this.file,
    required this.type,
    required this.size,
    required this.fileName,
  });

  factory MediaUpload.fromJson(Map<String, dynamic> json) {
    return MediaUpload(
      id: json['id'],
      file: json['file'],
      type: json['type'],
      size: json['size'],
      fileName: json['file_name'],
    );
  }
}
