import 'package:flutter/material.dart';
import 'package:kutubxona/config/theme/app_colors.dart';

ThemeData darkTheme() {
  return ThemeData(
    fontFamily: 'Cairo',
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(surface: AppColors().darkBack),
  );
}
