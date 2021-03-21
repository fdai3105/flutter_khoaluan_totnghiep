import 'package:flutter/material.dart';

class AppStyles {
  AppStyles._();

  static final BorderRadius radiusNormal = BorderRadius.circular(8);

  static final List<BoxShadow> shadow = [
    const BoxShadow(
      color: Colors.black12,
      blurRadius: 8,
      offset: Offset(0, 0),
    )
  ];
}
