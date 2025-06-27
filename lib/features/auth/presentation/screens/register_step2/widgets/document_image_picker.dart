import 'dart:io';
import 'package:flutter/material.dart';

class ImagePickerBox extends StatelessWidget {
  final File? file;
  final String? imageUrl;
  final VoidCallback onTap;

  const ImagePickerBox({
    Key? key,
    this.file,
    this.imageUrl,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ImageProvider? imageProvider;

    if (file != null) {
      imageProvider = FileImage(file!);
    } else if (imageUrl != null) {
      imageProvider = NetworkImage(imageUrl!);
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 90,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
          image: imageProvider != null
              ? DecorationImage(image: imageProvider, fit: BoxFit.cover)
              : null,
        ),
        child: imageProvider == null
            ? Icon(
                Icons.image,
                size: 40,
                color: Theme.of(context).colorScheme.primary,
              )
            : null,
      ),
    );
  }
}
