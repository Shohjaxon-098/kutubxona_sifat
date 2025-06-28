import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kutubxona/config/theme/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final void Function()? onPressed;
  final String? text;
  final double height;
  final double borderRadius;
  final Color? color;
  final TextStyle? textStyle;
  final Widget? child;
  final BorderSide? side;

  const PrimaryButton({
    super.key,
    this.onPressed,
    this.text,
    this.height = 50,
    this.borderRadius = 16,
    this.color,
    this.textStyle,
    this.child,
    this.side,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        side: side,
        backgroundColor: color ?? AppColors().primaryColor,
        minimumSize: Size(double.infinity, height.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),
      ),
      child:
          child ??
          Text(
            text ?? '',
            style:
                textStyle ??
                TextStyle(
                  fontSize: 15.sp,
                  color: AppColors().white,
                  fontWeight: FontWeight.w500,
                ),
          ),
    );
  }
}
