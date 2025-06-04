import 'package:flutter/material.dart';
import 'package:kutubxona/core/util/toast_message.dart';
import 'package:kutubxona/export.dart';

class SubmitButton extends StatelessWidget {
  final List<TextEditingController> controllers;
  final OtpState state;

  const SubmitButton({
    super.key,
    required this.controllers,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final isLoading = state is OtpLoading;

    return PrimaryButton(
      onPressed:
          isLoading
              ? null
              : () async {
                final otpCode = controllers.map((c) => c.text).join();

                // 🔒 Validation check
                if (otpCode.length < controllers.length ||
                    otpCode.contains(RegExp(r'\D'))) {
                  ToastMessage.showToast("Кодни киритинг", context);
                  return;
                }

                final id = AppConfig.libraryId.toString();
                final phoneNumber = await AppConfig.getPhone;

                context.read<OtpBloc>().add(
                  SubmitOtp(
                    phoneNumber: phoneNumber.toString(),
                    libraryId: id,
                    otp: int.parse(otpCode),
                  ),
                );
              },
      child:
          isLoading
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
