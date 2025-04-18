import 'package:flutter/services.dart';
import 'package:kutubxona/core/util/important.dart';

class TextFieldInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscure;
  final String? hint;
  final int? lengthInput;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const TextFieldInput({
    super.key,
    required this.label,
    required this.controller,
    this.obscure = false,
    this.hint,
    this.lengthInput,
    this.keyboardType,
    this.suffixIcon,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          obscuringCharacter: '*',
          keyboardType: keyboardType,
          onChanged: onChanged,
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
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          cursorColor: Theme.of(context).colorScheme.tertiary,
          cursorWidth: 1,
          cursorHeight: 22,
          decoration: InputDecoration(
            constraints: const BoxConstraints(minHeight: 50),
            suffixIcon: suffixIcon,
            isDense: true,
            hintText: hint,
            errorStyle: const TextStyle(fontSize: 12),
            hintStyle: TextStyle(
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
