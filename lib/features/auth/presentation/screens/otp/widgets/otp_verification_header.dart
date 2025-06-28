import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kutubxona/export.dart';

class OtpVerificationHeader extends StatelessWidget {
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 84.w,
            height: 84.h,
            decoration: BoxDecoration(
              color: AppColors().white,
              borderRadius: BorderRadius.circular(28.r),
              boxShadow: [
                BoxShadow(
                  blurRadius: 0,
                  spreadRadius: 5,
                  color: AppColors().cardShadow,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: SvgPicture.asset(AppImages().secure),
            ),
          ),
          SizedBox(height: 33.h),
          Text(
            'Телефонингизга юборилган\nкодни киритинг',
            style: TextStyle(
              color: AppColors().white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
