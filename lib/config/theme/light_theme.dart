import 'package:flutter/material.dart';
import 'package:kutubxona/config/theme/app_colors.dart';

ThemeData theme(BuildContext context) {
  return ThemeData(

    brightness: Brightness.light,
    fontFamily: 'Cairo',
    colorScheme: ColorScheme.light(
      primaryContainer: AppColors().white,
      secondary: AppColors().searchBackLight,
      primary: AppColors().searchInLight,
      tertiary: AppColors().textColor,
      scrim: AppColors().cardColor,
      primaryFixed: AppColors().shimmerBaseLight,
      primaryFixedDim: AppColors().shimmerHighLight,
    ),
  );
}

