import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        _buildRadioTile(title: "Паспорт", value: 'passport'),
        SizedBox(height: 4.h),
        _buildRadioTile(
          title: "Туғилганлик ҳақида гувоҳнома",
          value: 'birth_certificate',
        ),
      ],
    );
  }

  Widget _buildRadioTile({required String title, required String value}) {
    return RadioListTile<String>(
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 0),
      activeColor: AppColors().searchInDark,
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }
}
