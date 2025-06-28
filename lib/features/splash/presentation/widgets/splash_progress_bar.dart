import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kutubxona/export.dart';

class SplashProgressBar extends StatelessWidget {
  final AnimationController controller;

  const SplashProgressBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240.w,
      child: AnimatedBuilder(
        animation: controller,
        builder: (_, __) {
          return LinearProgressIndicator(
            value: controller.value,
            backgroundColor: AppColors().linerBackgroundColor,
            valueColor: AlwaysStoppedAnimation(AppColors().white),
            borderRadius: BorderRadius.circular(5.r),
          );
        },
      ),
    );
  }
}
