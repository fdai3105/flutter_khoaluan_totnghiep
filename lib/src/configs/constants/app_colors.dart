import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  ///
  static const Color primary = Color.fromRGBO(108, 94, 207, 1);
  static const Color secondary = Color.fromRGBO(31, 29, 43, 1);

  static const Color dark45 = Colors.grey;
  static const Color dark = Colors.black;

  /// dark mode colors
  static const Color darkModeBg = secondary;
  static const Color darkModeText = Colors.white;
  static const Color darkModeHint = Colors.white60;
  static const Color darkModeIcon = Colors.white;

  /// light mode colors
  static const Color lightModeBg = Colors.white;
  static Color lightModeText = Colors.grey.shade800;
  static const Color lightModeHint = Colors.black87;
  static const Color lightModeIcon = Colors.white;

  //
  static Color shimmerBase = Colors.grey.shade300;
  static Color shimmerHighlight = Colors.grey.shade100;
}
