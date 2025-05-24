import 'package:flutter/material.dart';

class SubmitButtonRegister extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const SubmitButtonRegister({
    super.key,
    required this.onPressed,
    this.text = 'Кириш',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(onPressed: onPressed, child: Text(text)),
    );
  }
}
