export 'routers.dart';
export 'shared_pref.dart';
export 'maths.dart';
export 'formats.dart';

import 'package:flutter/material.dart';

void snackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(message ?? "")));
}