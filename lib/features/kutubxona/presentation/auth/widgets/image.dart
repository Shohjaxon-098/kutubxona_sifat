import 'dart:io';

import 'package:kutubxona/core/util/important.dart';
  Widget imageBox({required File? file, required void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 80,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        child:
            file != null
                ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(file, fit: BoxFit.cover),
                )
                : const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image, size: 28, color: Colors.grey),
                    Icon(Icons.add, size: 18, color: Colors.grey),
                  ],
                ),
      ),
    );
  }