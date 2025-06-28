import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawerItem extends StatelessWidget {
  final Widget icon;
  final String label;
  final VoidCallback onTap;

  const DrawerItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      horizontalTitleGap: 12.w,
      minLeadingWidth: 24.w,
      title: Text(
        label,
        style: TextStyle(
          color: Theme.of(context).colorScheme.tertiary,
          fontFamily: 'Roboto',
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5.w,
          decoration: TextDecoration.none,
          decorationColor: Colors.transparent,
          decorationStyle: TextDecorationStyle.solid,
          decorationThickness: 1.0,
          height: 1.2.h,
          shadows: [
            Shadow(
              color: Colors.black12,
              offset: Offset(0, 1.h),
              blurRadius: 2.r,
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
