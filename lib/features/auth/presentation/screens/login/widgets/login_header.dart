import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kutubxona/export.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

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
              image: DecorationImage(
                image: AssetImage(AppImages().logo),
                scale: 11,
              ),
            ),
          ),
          SizedBox(height: 33.h),
          Text(
            'Ассалому алайкум\nХуш келибсиз!',
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
