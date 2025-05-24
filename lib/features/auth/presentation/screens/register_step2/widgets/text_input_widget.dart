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

  const CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
    required this.keyboardType,
    required this.validator,
    this.obscure = false,
    this.onTap,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldInput(
      label: label,
      controller: controller,
      hint: label,
      keyboardType: keyboardType,
      validator: validator,
      obscure: obscure,
      onTap: onTap,
      readOnly: readOnly,
    );
  }
}
