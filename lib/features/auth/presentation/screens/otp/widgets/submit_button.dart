import 'package:flutter/material.dart';
import 'package:kutubxona/export.dart';

class SubmitButton extends StatelessWidget {
  final List<TextEditingController> controllers;
  final OtpState state;

  SubmitButton({required this.controllers, required this.state});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: () async {
        final id = await AppConfig.libraryId.toString();
        final otpCode = controllers.map((c) => c.text).join();
        final phoneNumber = await AppConfig.getPhone;
        // OTP yuborish
        context.read<OtpBloc>().add(
          SubmitOtp(
            phoneNumber: phoneNumber.toString(),
            libraryId: id,
            otp: int.parse(otpCode),
          ),
        );
      },
      ttext:
          state is OtpLoading
              ? SizedBox(
                width: 26,
                height: 26,
                child: const CircularProgressIndicator(),
              )
              : Text(
                "Кириш",
                style: TextStyle(color: AppColors().white, fontSize: 15),
              ),
    );
  }
}
