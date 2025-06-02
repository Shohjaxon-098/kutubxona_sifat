import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kutubxona/config/config_exports.dart';

class ProfileImagePicker extends StatefulWidget {
  const ProfileImagePicker({super.key});

  @override
  State<ProfileImagePicker> createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  File? _imageFile;

  Future<void> _showPickOptions(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder:
          (_) => SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("Kameradan olish"),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo),
                  title: const Text("Galereyadan tanlash"),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: source, imageQuality: 85);

    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = AppColors().primaryColor;

    return InkWell(
      onTap: () => _showPickOptions(context),
      borderRadius: BorderRadius.circular(50),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: color),
            ),
            child: ClipOval(
              child:
                  _imageFile != null
                      ? Image.file(_imageFile!, fit: BoxFit.cover)
                      : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          'assets/icons/person.svg',
                          fit: BoxFit.cover,
                          color: color,
                        ),
                      ),
            ),
          ),
          const SizedBox(width: 12),
          Text('Сурат юклаш', style: TextStyle(color: color, fontSize: 16)),
        ],
      ),
    );
  }
}
