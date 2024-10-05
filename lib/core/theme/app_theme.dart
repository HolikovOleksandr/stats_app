import 'package:flutter/material.dart';
import 'package:stats_app/core/constants/app_colors.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.lightBackground,
      useMaterial3: true,
      textTheme: _texts,
      appBarTheme: _appBar,
      colorScheme: _colorsScheme,
      elevatedButtonTheme: _elevationButton,
      inputDecorationTheme: _textInput.copyWith(
        fillColor: AppColors.lightInputText,
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.darkBackground,
      useMaterial3: true,
      textTheme: _texts,
      appBarTheme: _appBar,
      colorScheme: _colorsScheme,
      elevatedButtonTheme: _elevationButton,
      inputDecorationTheme: _textInput.copyWith(
        fillColor: AppColors.darkInputText,
      ),
    );
  }

  static final _colorsScheme = ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    primary: AppColors.primary,
    secondary: AppColors.secondary,
  );

  static const _appBar = AppBarTheme(
    color: Colors.transparent,
    elevation: 0,
  );

  static const _texts = null;

  static final _textInput = InputDecorationTheme(
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
  );

  static final _elevationButton = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: AppColors.white,
      backgroundColor: AppColors.primary,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      minimumSize: const Size(double.infinity, 48),
    ),
  );
}
