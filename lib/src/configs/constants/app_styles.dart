import 'package:flutter/material.dart';

class AppStyles {
  AppStyles._();

  static final BorderRadius radiusNormal = BorderRadius.circular(6);

  static final List<BoxShadow> shadow = [
     const BoxShadow(
      color: Colors.black12,
      blurRadius: 10,
      offset: Offset(0, 0),
    )
  ];
}
