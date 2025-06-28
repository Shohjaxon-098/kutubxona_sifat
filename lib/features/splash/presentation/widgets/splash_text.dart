import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashText extends StatelessWidget {
  const SplashText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Liber",
      style: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.2.w,
      ),
    );
  }
}
