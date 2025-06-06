import 'package:flutter/services.dart';
import 'package:kutubxona/export.dart';

class TextFieldInput extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final bool obscure;
  final String? hint;
  final int? lengthInput;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final void Function()? onTap;
  final String? initialValue;
  final int? maxLength;
  const TextFieldInput({
    super.key,
    required this.label,
    this.controller,
    this.obscure = false,
    this.hint,
    this.lengthInput,
    this.keyboardType,
    this.suffixIcon,
    this.onChanged,
    this.validator,
    this.readOnly,
    this.onTap,
    this.initialValue,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          maxLength: maxLength,
          readOnly: readOnly ?? false,
          controller: controller,
          obscureText: obscure,
          obscuringCharacter: '*',
          keyboardType: keyboardType,
          onChanged: onChanged,
          onTap: onTap,
          validator:
              validator ??
              (value) {
                if (value == null || value.isEmpty) {
                  return 'Iltimos, $label maydonini to‘ldiring';
                }
                return null;
              },
          inputFormatters: [
            if (lengthInput != null)
              LengthLimitingTextInputFormatter(lengthInput),
          ],
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            fontFamily: 'Roboto',
          ),
          cursorColor: Theme.of(context).colorScheme.tertiary,
          cursorWidth: 1,
          cursorHeight: 22,
          initialValue: initialValue,
          decoration: InputDecoration(
            constraints: const BoxConstraints(minHeight: 50),
            suffixIcon: suffixIcon,
            isDense: true,
            hintText: hint,
            errorStyle: const TextStyle(fontSize: 12),
            hintStyle: TextStyle(
              fontFamily: 'Roboto',
              color: AppColors().hintColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors().border),
              borderRadius: BorderRadius.circular(16),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors().border),
              borderRadius: BorderRadius.circular(16),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors().border),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ],
    );
  }
}
