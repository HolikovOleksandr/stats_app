import 'package:flutter/material.dart';
import 'package:stats_app/core/constants/app_colors.dart';
import 'package:stats_app/core/constants/app_fotns.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      appBarTheme: _appBar(AppColors.darkText),
      colorScheme: _colorsScheme,
      elevatedButtonTheme: _elevatedButton,
      scaffoldBackgroundColor: AppColors.lightBackground,
      textTheme: _buildTextTheme(AppColors.darkText),
      inputDecorationTheme: _textInput.copyWith(
        fillColor: const Color(0x89F2F2F2),
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      appBarTheme: _appBar(AppColors.lightText),
      colorScheme: _colorsScheme,
      elevatedButtonTheme: _elevatedButton,
      scaffoldBackgroundColor: AppColors.darkBackground,
      textTheme: _buildTextTheme(AppColors.lightText),
      inputDecorationTheme: _textInput.copyWith(
        fillColor: AppColors.darkInputText,
        labelStyle: AppFonts.bodyM.copyWith(
          color: AppColors.white,
        ),
      ),
    );
  }

  static TextTheme _buildTextTheme(Color color) => TextTheme(
        titleLarge: AppFonts.titleL.copyWith(color: color),
        titleMedium: AppFonts.titleM.copyWith(color: color),
        titleSmall: AppFonts.titleS.copyWith(color: color),
        bodyLarge: AppFonts.bodyL.copyWith(color: color),
        bodyMedium: AppFonts.bodyM.copyWith(color: color),
        bodySmall: AppFonts.bodyS.copyWith(color: color),
      );

  static final _textInput = InputDecorationTheme(
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
  );

  static final _elevatedButton = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: AppColors.white,
      backgroundColor: AppColors.primary,
      minimumSize: const Size(double.infinity, 52),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      textStyle: AppFonts.bodyL.copyWith(fontWeight: FontWeight.w900),
    ),
  );

  static final _colorsScheme = ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    primary: AppColors.primary,
    secondary: AppColors.secondary,
  );

  static _appBar(color) => AppBarTheme(
        centerTitle: true,
        titleTextStyle: AppFonts.titleM.copyWith(color: color),
        color: Colors.transparent,
        elevation: 0,
      );
}
