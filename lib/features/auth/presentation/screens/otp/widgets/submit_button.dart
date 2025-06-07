import 'package:flutter/material.dart';
import 'package:kutubxona/core/util/toast_message.dart';
import 'package:kutubxona/export.dart';

class SubmitButton extends StatelessWidget {
  final TextEditingController controller;
  final OtpState state;
  final VoidCallback onPressed;

  const SubmitButton({
    Key? key,
    required this.controller,
    required this.state,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoading = state is OtpLoading;

    return PrimaryButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const SizedBox(
              width: 26,
              height: 26,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : Text(
              "Кириш",
              style: TextStyle(color: AppColors().white, fontSize: 15),
            ),
    );
  }
}
