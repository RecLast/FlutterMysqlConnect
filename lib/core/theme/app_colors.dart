import 'package:flutter/material.dart';

class AppColors {
  // Mavi Tema
  static const lightBlue = {
    'primary': Color(0xFF0063C8),
    'secondary': Color(0xFF0FB9F4),
    'tertiary': Color(0xFF14B3F2),
  };

  static const darkBlue = {
    'primary': Color(0xFF174193),
    'secondary': Color(0xFF193787),
  };

  static const yellow = {
    'primary': Color(0xFFC25008),
    'secondary': Color(0xFFF9C10A),
    'tertiary': Color(0xFFFAD20E),
  };

  static const black = {
    'primary': Color(0xFF4B4B4B),
    'secondary': Color(0xFF030724),
    'tertiary': Color(0xFF051843),
    'dark': Color(0xFF020201),
  };

  static const white = {
    'primary': Color(0xFFFFFFFF),
    'secondary': Color(0xFFFAFBFA),
    'tertiary': Color(0xFFE4ECFC),
  };

  // Gradient Renkler
  static const gradient = {
    'start': Color(0xFF174193), // darkBlue.primary
    'end': Color(0xFF0063C8), // lightBlue.primary
  };

  // Sarı Tema Varyasyonu
  static const yellowTheme = {
    'primary': Color(0xFFF9C10A),
    'secondary': Color(0xFFFAD20E),
    'tertiary': Color(0xFFFFC107),
    'dark': Color(0xFFC25008),
  };

  // Kırmızı Tema Varyasyonu
  static const redTheme = {
    'primary': Color(0xFFE53935),
    'secondary': Color(0xFFF44336),
    'tertiary': Color(0xFFEF5350),
    'dark': Color(0xFFC62828),
  };

  // Yeşil Tema Varyasyonu
  static const greenTheme = {
    'primary': Color(0xFF43A047),
    'secondary': Color(0xFF4CAF50),
    'tertiary': Color(0xFF66BB6A),
    'dark': Color(0xFF2E7D32),
  };

  // Renk Körü Modu
  static const colorBlindTheme = {
    'primary': Color(0xFF000000),
    'secondary': Color(0xFF4B4B4B),
    'accent': Color(0xFFFFFFFF),
    'background': Color(0xFFF5F5F5),
    'text': Color(0xFF000000),
  };

  // Karanlık Tema
  static const darkTheme = {
    'background': Color(0xFF030724),
    'surface': Color(0xFF051843),
    'primary': Color(0xFF0063C8),
    'onBackground': Color(0xFFE4ECFC),
    'onSurface': Color(0xFFFFFFFF),
  };

  // Aydınlık Tema
  static const lightTheme = {
    'background': Color(0xFFFFFFFF),
    'surface': Color(0xFFFAFBFA),
    'primary': Color(0xFF0063C8),
    'onBackground': Color(0xFF030724),
    'onSurface': Color(0xFF4B4B4B),
  };
}
