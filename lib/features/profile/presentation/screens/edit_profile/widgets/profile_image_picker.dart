import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kutubxona/config/config_exports.dart';

class ProfileImagePicker extends StatefulWidget {
  final void Function()? onTap;
  final File? imageFile;
  final String? imageUrl;

  const ProfileImagePicker({
    super.key,
    required this.onTap,
    this.imageFile,
    this.imageUrl,
  });

  @override
  State<ProfileImagePicker> createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  @override
  Widget build(BuildContext context) {
    final color = AppColors().primaryColor;

    Widget imageWidget;
    if (widget.imageFile != null) {
      imageWidget = Image.file(
        widget.imageFile!,
        fit: BoxFit.cover,
        width: 64,
        height: 64,
      );
    } else if (widget.imageUrl != null && widget.imageUrl!.isNotEmpty) {
      imageWidget = Image.network(
        widget.imageUrl!,
        fit: BoxFit.cover,
        width: 64,
        height: 64,
        errorBuilder: (_, __, ___) => _defaultIcon(color),
      );
    } else {
      imageWidget = _defaultIcon(color);
    }

    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(50),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: color, width: 2),
            ),
            child: ClipOval(child: imageWidget),
          ),
          const SizedBox(width: 12),
          Text('Сурат юклаш', style: TextStyle(color: color, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _defaultIcon(Color color) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SvgPicture.asset(
        'assets/icons/person.svg',
        fit: BoxFit.cover,
        color: color,
      ),
    );
  }
}
