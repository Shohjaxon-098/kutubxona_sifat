import 'dart:io';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImageFromCamera() async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
  if (pickedFile != null) {
    return File(pickedFile.path);
  }
  return null;
}
