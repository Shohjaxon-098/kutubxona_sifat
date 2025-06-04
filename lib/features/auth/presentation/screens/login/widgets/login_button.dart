import 'package:flutter/material.dart';
import 'package:kutubxona/export.dart';

class LoginButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const LoginButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: isLoading ? null : onPressed,
      child:
          isLoading
              ? const SizedBox(
                width: 26,
                height: 26,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
              : Text(
                "Кириш",
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors().white,
                  fontWeight: FontWeight.w500,
                ),
              ),
    );
  }
}
