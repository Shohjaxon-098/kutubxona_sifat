import 'package:flutter/material.dart';
import 'package:kutubxona/export.dart';

class LoginPasswordField extends StatefulWidget {
  final TextEditingController controller;

  const LoginPasswordField({super.key, required this.controller});

  @override
  State<LoginPasswordField> createState() => _LoginPasswordFieldState();
}

class _LoginPasswordFieldState extends State<LoginPasswordField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldInput(
      label: 'Парол',
      controller: widget.controller,
      hint: '********',
      obscure: _obscureText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Parolni kiriting';
        } else if (value.length < 6) {
          return 'Parol kamida 6 ta belgidan iborat bo‘lishi kerak';
        }
        return null;
      },
      suffixIcon: GestureDetector(
        onTap: _toggleVisibility,
        child: SvgPicture.asset(
          fit: BoxFit.scaleDown,
          _obscureText
              ? 'assets/icons/eye-hide.svg'
              : 'assets/icons/eye-show.svg',

          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
    );
  }
}
