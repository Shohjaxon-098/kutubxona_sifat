import 'package:flutter/material.dart';
import 'package:kutubxona/features/widgets/phonetextfield_widget.dart';

class LoginPhoneField extends StatelessWidget {
  final TextEditingController controller;

  const LoginPhoneField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return PhoneTextfieldWidget(phoneController: controller);
  }
}
