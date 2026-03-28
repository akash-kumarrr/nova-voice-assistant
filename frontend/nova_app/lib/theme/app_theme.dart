import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  AppColors._();

  static const bg         = Color(0xFF080C14);
  static const surface    = Color(0xFF0F1520);
  static const surface2   = Color(0xFF161B27);
  static const border     = Color(0xFF1E2535);
  static const border2    = Color(0xFF2A2F3E);

  static const violet     = Color(0xFF7C3AED);
  static const violetLight= Color(0xFF8B5CF6);
  static const violetDark = Color(0xFF5B21B6);
  static const violetDeep = Color(0xFF1E0A3C);

  static const amber      = Color(0xFFF59E0B);
  static const green      = Color(0xFF4ADE80);
  static const blue       = Color(0xFF60A5FA);
  static const pink       = Color(0xFFF472B6);

  static const textPrimary   = Colors.white;
  static const textSecondary = Color(0xFFCDD5E0);
  static const textMuted     = Color(0xFF6B7280);
  static const textDim       = Color(0xFF3D4A5C);
}

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get displayLarge => GoogleFonts.syne(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
        letterSpacing: 3,
      );

  static TextStyle get displaySmall => GoogleFonts.syne(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: 1,
      );

  static TextStyle get body => GoogleFonts.dmSans(
        fontSize: 14.5,
        height: 1.55,
        color: AppColors.textSecondary,
      );

  static TextStyle get bodySmall => GoogleFonts.dmSans(
        fontSize: 12,
        color: AppColors.textMuted,
      );

  static TextStyle get caption => GoogleFonts.dmSans(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      );

  static TextStyle get hint => GoogleFonts.dmSans(
        fontSize: 14.5,
        color: AppColors.textDim,
      );
}

class AppTheme {
  AppTheme._();

  static ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.bg,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.violet,
          surface: AppColors.surface,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
        ),
      );
}
