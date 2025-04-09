import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kutubxona/config/theme/app_colors.dart';

class OtpWidget extends StatelessWidget {
  const OtpWidget({
    super.key,
    required this.otpController,
    required this.onChanged,
    required this.color,
  });
  final TextEditingController otpController;

  final void Function(String)? onChanged;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: Center(
        child: TextFormField(
          cursorColor: AppColors().black,
          cursorHeight: 20,
          controller: otpController,
          keyboardType: TextInputType.number,
          style: TextStyle(
            color: color,
            fontSize: 26,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly,
          ],
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 14),
            border: InputBorder.none,
            hintText: ('_'),
            hintStyle: TextStyle(fontSize: 24, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
