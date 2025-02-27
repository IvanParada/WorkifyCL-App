import 'package:Workify/core/themes/color_theme.dart';
import 'package:flutter/material.dart';

const TextTheme appTextTheme = TextTheme(
  bodyLarge: TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  ),
  bodyMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color:  AppColors.textPrimary,
  ),
  bodySmall: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color:  AppColors.textPrimary,
  ),
  titleLarge: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary
  )
);
