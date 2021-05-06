// Flutter imports:
import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  ///
  static const Color primary = Color.fromRGBO(108, 94, 207, 1);
  static const Color secondary = Color.fromRGBO(31, 29, 43, 1);
  static const Color tertiary = Color.fromRGBO(37, 40, 54, 1);

  static const Color dark45 = Colors.grey;
  static const Color dark = Colors.black;

  /// dark mode colors
  static const Color darkModeBg = secondary;
  static const Color darkModeText = Colors.white;
  static const Color darkModeHint = Colors.white60;
  static const Color darkModeIcon = Colors.white;
  static Color darkModeCard = tertiary;
  static Color darkModeShimmerHighlight = Colors.grey;

  /// light mode colors
  static const Color lightModeBg = Colors.white;
  static const Color lightModeText = Colors.black87;
  static const Color lightModeHint = Colors.black87;
  static const Color lightModeIcon = Colors.white;
  static  Color lightModeCard = Colors.white;
  static Color lightModeShimmerHighlight = Colors.grey.shade300;
}
