import 'package:flutter/material.dart';
import '../configs.dart';

class AppStyles {
  AppStyles._();

  static const paddingBody = EdgeInsets.symmetric(horizontal: 10);

  static final BorderRadius radiusNormal = BorderRadius.circular(6);

  static final List<BoxShadow> shadow = [
    const BoxShadow(
      color: Colors.black12,
      blurRadius: 10,
      offset: Offset(0, 0),
    )
  ];

  /// themes
  static ThemeData darkMode(BuildContext context) {
    return ThemeData(
      brightness: Brightness.dark,
      backgroundColor: AppColors.secondary,
      cardColor: const Color.fromRGBO(37, 40, 54, 1),
      iconTheme: const IconThemeData(color: Colors.white),
      textTheme: const TextTheme(
        headline6: TextStyle(color: AppColors.darkModeText),
        bodyText1: TextStyle(fontSize: 16),
        bodyText2: TextStyle(color: AppColors.darkModeText),
        subtitle1: TextStyle(fontSize: 14, color: AppColors.darkModeHint),
        subtitle2: TextStyle(color: Colors.black87),
      ),
      hintColor: Colors.grey,
      snackBarTheme: const SnackBarThemeData(
          backgroundColor: Colors.black87,
          contentTextStyle: TextStyle(color: AppColors.darkModeText),
          elevation: 1),
    );
  }

  static ThemeData lightMode() {
    return ThemeData(
      brightness: Brightness.light,
      backgroundColor: AppColors.lightModeBg,
      iconTheme: const IconThemeData(),
      textTheme: const TextTheme(
        headline6: TextStyle(color: AppColors.darkModeText),
        bodyText1: TextStyle(color: AppColors.darkModeText, fontSize: 16),
        bodyText2: TextStyle(color: AppColors.darkModeText),
        subtitle1: TextStyle(color: AppColors.lightModeHint, fontSize: 14),
        subtitle2: TextStyle(color: Colors.black87),
      ),
      hintColor: Colors.grey,
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: Colors.black87,
        contentTextStyle: TextStyle(color: AppColors.darkModeText),
        elevation: 1,
      ),
    );
  }
}
