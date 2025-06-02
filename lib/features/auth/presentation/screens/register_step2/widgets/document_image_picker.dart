import 'dart:io';
import 'package:flutter/material.dart';

class ImagePickerBox extends StatelessWidget {
  final File? file;
  final VoidCallback onTap;

  const ImagePickerBox({Key? key, this.file, required this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 90,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child:
            file == null
                ? const Icon(Icons.image, size: 40)
                : Image.file(file!, fit: BoxFit.cover),
      ),
    );
  }
}
