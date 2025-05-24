import 'package:flutter/material.dart';
import 'package:kutubxona/features/widgets/textfield_input.dart';

class BirthDatePickerField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onTap;
  final String? Function(String?) validator;

  const BirthDatePickerField({
    Key? key,
    required this.controller,
    required this.onTap,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldInput(
      label: "Туғилган санаси",
      controller: controller,
      hint: "Туғилган санаси",
      keyboardType: TextInputType.datetime,
      validator: validator,
      onTap: onTap,
      readOnly: true,
    );
  }
}
