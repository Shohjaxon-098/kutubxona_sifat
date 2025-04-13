// ignore_for_file: file_names

import 'package:kutubxona/core/util/important.dart';
export 'package:flutter/services.dart';

Widget textFieldW({
  required String label,
  required TextEditingController controller,
  bool obscure = false,
  String? hint,
  int? lengthInput,
  TextInputType? keyboardType,
  void Function(String)? onChanged,
  Widget? suffixIcon,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      const SizedBox(height: 6),
      SizedBox(
        height: 50,
        child: TextFormField(
          onChanged:onChanged ,
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          inputFormatters: [LengthLimitingTextInputFormatter(lengthInput)],
          cursorColor: AppColors().black,
          cursorWidth: 1,
          cursorHeight: 22,
          obscureText: obscure,
          obscuringCharacter: '*',
          
          decoration: InputDecoration(suffixIcon: suffixIcon,
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
