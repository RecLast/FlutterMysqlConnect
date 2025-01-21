import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Ubuntu Font Styles (Temel yazılar için)
  static const ubuntuRegular = TextStyle(
    fontFamily: 'Ubuntu',
    fontWeight: FontWeight.w400,
    color: Color(0xFF4B4B4B), // black.primary
  );

  static const ubuntuMedium = TextStyle(
    fontFamily: 'Ubuntu',
    fontWeight: FontWeight.w500,
    color: Color(0xFF4B4B4B),
  );

  static const ubuntuBold = TextStyle(
    fontFamily: 'Ubuntu',
    fontWeight: FontWeight.w700,
    color: Color(0xFF4B4B4B),
  );

  // Rowdies Font Styles (Başlıklar ve logo için)
  static const rowdiesLight = TextStyle(
    fontFamily: 'Rowdies',
    fontWeight: FontWeight.w300,
    color: Color(0xFF4B4B4B),
  );

  static const rowdiesRegular = TextStyle(
    fontFamily: 'Rowdies',
    fontWeight: FontWeight.w400,
    color: Color(0xFF4B4B4B),
  );

  static const rowdiesBold = TextStyle(
    fontFamily: 'Rowdies',
    fontWeight: FontWeight.w700,
    color: Color(0xFF4B4B4B),
  );

  // Audiowide Font Style (Özel kullanımlar için)
  static const audiowide = TextStyle(
    fontFamily: 'Audiowide',
    fontWeight: FontWeight.w400,
    color: Color(0xFF4B4B4B),
  );

  // Heading Styles
  static TextStyle h1 = rowdiesBold.copyWith(fontSize: 32);
  static TextStyle h2 = rowdiesBold.copyWith(fontSize: 28);
  static TextStyle h3 = rowdiesBold.copyWith(fontSize: 24);
  static TextStyle h4 = rowdiesBold.copyWith(fontSize: 20);
  static TextStyle h5 = rowdiesBold.copyWith(fontSize: 18);
  static TextStyle h6 = rowdiesBold.copyWith(fontSize: 16);

  // Body Text Styles
  static TextStyle bodyLarge = ubuntuRegular.copyWith(fontSize: 16);
  static TextStyle bodyMedium = ubuntuRegular.copyWith(fontSize: 14);
  static TextStyle bodySmall = ubuntuRegular.copyWith(fontSize: 12);

  // Button Text Styles
  static TextStyle buttonLarge = rowdiesBold.copyWith(
    fontSize: 16,
    color: AppColors.white['primary'],
  );
  static TextStyle buttonMedium = rowdiesBold.copyWith(
    fontSize: 14,
    color: AppColors.white['primary'],
  );
  static TextStyle buttonSmall = rowdiesBold.copyWith(
    fontSize: 12,
    color: AppColors.white['primary'],
  );

  // Link Text Styles
  static TextStyle link = ubuntuMedium.copyWith(
    fontSize: 14,
    color: AppColors.lightBlue['primary'],
    decoration: TextDecoration.underline,
  );

  // Caption Text Styles
  static TextStyle caption = ubuntuRegular.copyWith(
    fontSize: 12,
    color: AppColors.black['primary'],
  );

  // Label Text Styles
  static TextStyle label = ubuntuMedium.copyWith(
    fontSize: 14,
    color: AppColors.black['primary'],
  );

  // Special Text Styles
  static TextStyle logo = audiowide.copyWith(
    fontSize: 32,
    color: AppColors.darkBlue['primary'],
  );

  static TextStyle gameTitle = rowdiesBold.copyWith(
    fontSize: 24,
    color: AppColors.darkBlue['primary'],
  );

  static TextStyle score = audiowide.copyWith(
    fontSize: 48,
    color: AppColors.yellow['secondary'],
  );
}
