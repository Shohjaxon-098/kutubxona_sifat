import 'dart:math';

import 'package:kutubxona/export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderCardWidget extends StatelessWidget {
  const HeaderCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260.h,
      decoration: BoxDecoration(
        color: AppColors().cardColor,
        borderRadius: BorderRadius.circular(24.r),
        image: DecorationImage(
          image: AssetImage(AppImages().mask),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_buildLogo(), SizedBox(height: 33.h), _buildHeaderText()],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 84.w,
      height: 84.w,
      decoration: BoxDecoration(
        color: AppColors().white,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 0,
            spreadRadius: 5.r,
            color: AppColors().cardShadow,
          ),
        ],
      ),
      child: Center(
        child: Image.asset(
          AppImages().logo,
          width: 38.w, // or even 40.w if more visible
          height: 38.w,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildHeaderText() {
    return Text(
      'Қайси худуддаги кутубхоналардан фойдаланмоқчисиз?',
      style: TextStyle(
        color: AppColors().white,
        fontSize: 20.adaptiveFont(),
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.center,
    );
  }
}

extension FontSizeExtension on num {
  double adaptiveFont() {
    return min(toDouble().sp, toDouble()); // max fontSize = this.toDouble()
  }
}
