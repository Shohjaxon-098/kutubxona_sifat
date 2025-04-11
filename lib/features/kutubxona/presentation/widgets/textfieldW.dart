import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kutubxona/config/theme/app_colors.dart';

Widget textFieldW({
  required String label,
  required TextEditingController controller,
  bool obscure = false,
  String? hint,
  int? lengthInput,
  TextInputType? keyboardType,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
      SizedBox(height: 6),
      SizedBox(
        height: 50,
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          inputFormatters: [LengthLimitingTextInputFormatter(lengthInput)],
          cursorColor: AppColors().black,
          cursorWidth: 1,
          cursorHeight: 22,
          obscureText: obscure,
          obscuringCharacter: '*',
          decoration: InputDecoration(
            isDense: true,
            hintStyle: TextStyle(
              color: AppColors().hintColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            hintText: hint,
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors().border),
              borderRadius: BorderRadius.circular(16),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors().border),
              borderRadius: BorderRadius.circular(16),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors().border),
              borderRadius: BorderRadius.circular(16),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
      ),
    ],
  );
}
