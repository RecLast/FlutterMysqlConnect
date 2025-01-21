import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  // Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.lightBlue['primary']!,
        onPrimary: AppColors.white['primary']!,
        secondary: AppColors.lightBlue['secondary']!,
        onSecondary: AppColors.white['primary']!,
        error: AppColors.redTheme['primary']!,
        onError: AppColors.white['primary']!,
        surface: AppColors.lightTheme['surface']!,
        onSurface: AppColors.lightTheme['onSurface']!,
      ),
      scaffoldBackgroundColor: AppColors.lightTheme['background'],
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightTheme['surface'],
        foregroundColor: AppColors.lightTheme['onSurface'],
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextStyles.h4,
      ),
      textTheme: TextTheme(
        displayLarge: AppTextStyles.h1,
        displayMedium: AppTextStyles.h2,
        displaySmall: AppTextStyles.h3,
        headlineMedium: AppTextStyles.h4,
        headlineSmall: AppTextStyles.h5,
        titleLarge: AppTextStyles.h6,
        bodyLarge: AppTextStyles.bodyLarge,
        bodyMedium: AppTextStyles.bodyMedium,
        bodySmall: AppTextStyles.bodySmall,
        labelLarge: AppTextStyles.buttonLarge,
        labelMedium: AppTextStyles.buttonMedium,
        labelSmall: AppTextStyles.buttonSmall,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.lightBlue['primary'],
          foregroundColor: AppColors.white['primary'],
          textStyle: AppTextStyles.buttonLarge,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.lightBlue['primary'],
          textStyle: AppTextStyles.link,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white['primary'],
        labelStyle: AppTextStyles.label,
        hintStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.black['primary']!.withOpacity(0.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.black['primary']!.withOpacity(0.1),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.black['primary']!.withOpacity(0.1),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.lightBlue['primary']!,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.redTheme['primary']!,
          ),
        ),
      ),
    );
  }

  // Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.lightBlue['primary']!,
        onPrimary: AppColors.white['primary']!,
        secondary: AppColors.lightBlue['secondary']!,
        onSecondary: AppColors.white['primary']!,
        error: AppColors.redTheme['primary']!,
        onError: AppColors.white['primary']!,
        surface: AppColors.darkTheme['surface']!,
        onSurface: AppColors.darkTheme['onSurface']!,
      ),
      scaffoldBackgroundColor: AppColors.darkTheme['background'],
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkTheme['surface'],
        foregroundColor: AppColors.darkTheme['onSurface'],
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextStyles.h4.copyWith(
          color: AppColors.darkTheme['onSurface'],
        ),
      ),
      textTheme: TextTheme(
        displayLarge: AppTextStyles.h1
            .copyWith(color: AppColors.darkTheme['onBackground']),
        displayMedium: AppTextStyles.h2
            .copyWith(color: AppColors.darkTheme['onBackground']),
        displaySmall: AppTextStyles.h3
            .copyWith(color: AppColors.darkTheme['onBackground']),
        headlineMedium: AppTextStyles.h4
            .copyWith(color: AppColors.darkTheme['onBackground']),
        headlineSmall: AppTextStyles.h5
            .copyWith(color: AppColors.darkTheme['onBackground']),
        titleLarge: AppTextStyles.h6
            .copyWith(color: AppColors.darkTheme['onBackground']),
        bodyLarge: AppTextStyles.bodyLarge
            .copyWith(color: AppColors.darkTheme['onBackground']),
        bodyMedium: AppTextStyles.bodyMedium
            .copyWith(color: AppColors.darkTheme['onBackground']),
        bodySmall: AppTextStyles.bodySmall
            .copyWith(color: AppColors.darkTheme['onBackground']),
        labelLarge: AppTextStyles.buttonLarge,
        labelMedium: AppTextStyles.buttonMedium,
        labelSmall: AppTextStyles.buttonSmall,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.lightBlue['primary'],
          foregroundColor: AppColors.white['primary'],
          textStyle: AppTextStyles.buttonLarge,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.lightBlue['secondary'],
          textStyle: AppTextStyles.link.copyWith(
            color: AppColors.lightBlue['secondary'],
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkTheme['surface'],
        labelStyle: AppTextStyles.label.copyWith(
          color: AppColors.darkTheme['onSurface'],
        ),
        hintStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.darkTheme['onSurface']!.withOpacity(0.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.darkTheme['onSurface']!.withOpacity(0.1),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.darkTheme['onSurface']!.withOpacity(0.1),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.lightBlue['secondary']!,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.redTheme['primary']!,
          ),
        ),
      ),
    );
  }
}
