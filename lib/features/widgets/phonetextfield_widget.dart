// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kutubxona/config/theme/app_colors.dart';
import 'package:kutubxona/core/util/formatters/phone_formatter.dart';

class PhoneTextfieldWidget extends StatelessWidget {
  const PhoneTextfieldWidget({super.key, required this.phoneController});
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Мобил рақам',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: phoneController,
          cursorColor: AppColors().black,
          cursorWidth: 1,
          keyboardType: TextInputType.phone,
          cursorHeight: 22,
          style: const TextStyle(fontSize: 16),
          inputFormatters: [
            LengthLimitingTextInputFormatter(12),
            FormatterUtil(),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Мобил рақамни киритинг';
            } else if (value.length < 12) {
              return 'Мобил рақам тўлиқ эмас';
            }
            return null;
          },
          decoration: InputDecoration(
            constraints: const BoxConstraints(minHeight: 50),
            errorStyle: const TextStyle(fontSize: 12),
            helperText: ' ', // ✅ Error uchun joy ajratib turadi
            isDense: true,
            hintStyle: TextStyle(
              color: AppColors().hintColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            hintText: '+998  _ _  _ _ _  _ _  _ _',

            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors().border),
              borderRadius: BorderRadius.circular(16),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors().border),
              borderRadius: BorderRadius.circular(16),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors().border),
              borderRadius: BorderRadius.circular(16),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors().border),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ],
    );
  }
}
