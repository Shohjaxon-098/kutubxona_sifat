class FileModel {
  final String file;
  final String name;
  final int size;

  FileModel({
    required this.file,
    required this.name,
    required this.size,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      file: json['file'] as String,
      name: json['name'] as String,
      size: json['size'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'file': file,
      'name': name,
      'size': size,
    };
  }
}
