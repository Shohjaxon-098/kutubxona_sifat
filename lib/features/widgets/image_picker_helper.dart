import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImageFromGallery() async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    return File(pickedFile.path);
  }
  return null;
}

Future<File?> pickImageFromCamera() async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
  if (pickedFile != null) {
    return File(pickedFile.path);
  }
  return null;
}

Future<File?> showImagePickerDialog(BuildContext context) async {
  return showModalBottomSheet<File?>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text("Галереядан танлаш"),
              onTap: () async {
                final file = await pickImageFromGallery();
                Navigator.of(context).pop(file);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Камерадан олиш"),
              onTap: () async {
                final file = await pickImageFromCamera();
                Navigator.of(context).pop(file);
              },
            ),
          ],
        ),
      );
    },
  );
}
