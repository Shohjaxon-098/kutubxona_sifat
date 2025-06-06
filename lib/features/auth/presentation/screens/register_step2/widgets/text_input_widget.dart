import 'package:flutter/material.dart';
import 'package:kutubxona/features/widgets/textfield_input.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?) validator;
  final bool obscure;
  final VoidCallback? onTap;
  final bool readOnly;
  final Widget? suffixIcon;
  final String? hint;
  final int? lengthInput;
  final int? maxLength;
  const CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
    required this.keyboardType,
    required this.validator,
    this.obscure = false,
    this.onTap,
    this.readOnly = false,
    this.suffixIcon,
    this.hint,
    this.lengthInput,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldInput(
      label: label,
      controller: controller,
      hint: hint,
      keyboardType: keyboardType,
      validator: validator,
      obscure: obscure,
      onTap: onTap,
      readOnly: readOnly,
      suffixIcon: suffixIcon,
      lengthInput: lengthInput,
      maxLength: maxLength,
    );
  }
}
