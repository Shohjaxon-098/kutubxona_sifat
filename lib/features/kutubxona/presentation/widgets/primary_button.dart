import 'package:flutter/material.dart';
import 'package:kutubxona/config/theme/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? text;
  final double height;
  final double borderRadius;
  final Color? color;
  final TextStyle? textStyle;
  final Widget? ttext;
  const PrimaryButton({
    super.key,
    required this.onPressed,
    this.text,
    this.height = 50,
    this.borderRadius = 16,
    this.color,
    this.textStyle,
    this.ttext,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? AppColors().primaryColor,
        minimumSize: Size(double.infinity, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child:
          ttext ??
          Text(
            text!,
            style:
                textStyle ??
                TextStyle(
                  fontSize: 15,
                  color: AppColors().white,
                  fontWeight: FontWeight.w500,
                ),
          ),
    );
  }
}
