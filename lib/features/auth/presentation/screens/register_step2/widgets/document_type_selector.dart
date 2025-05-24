import 'package:flutter/material.dart';
import 'package:kutubxona/export.dart';

class DocumentTypeRadio extends StatelessWidget {
  final String? groupValue;
  final ValueChanged<String?> onChanged;

  const DocumentTypeRadio({
    Key? key,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile<String>(
          activeColor: AppColors().searchInDark,
          value: 'passport',
          groupValue: groupValue,
          onChanged: onChanged,
          title: const Text("Паспорт"),
        ),
        RadioListTile<String>(
          activeColor: AppColors().searchInDark,
          value: 'birth_certificate',
          groupValue: groupValue,
          onChanged: onChanged,
          title: const Text("Туғилганлик ҳақида гувоҳнома"),
        ),
      ],
    );
  }
}
