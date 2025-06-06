import 'package:flutter/material.dart';
import 'package:kutubxona/config/theme/app_colors.dart';

ThemeData darkTheme() {
  return ThemeData(
    fontFamily: 'OpenSans',
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      surface: AppColors().darkBack,
      primaryContainer: AppColors().darkBack,
      secondary: AppColors().searchBackDark,
      primary: AppColors().searchInDark,
      tertiary: AppColors().white,
      scrim: AppColors().white,
      primaryFixed: AppColors().shimmerBaseDark,
      primaryFixedDim: AppColors().shimmerHighDark,
    ),
  );
}
