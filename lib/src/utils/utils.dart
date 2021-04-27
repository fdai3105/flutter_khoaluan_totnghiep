export 'routers.dart';
export 'shared_pref.dart';
export 'maths.dart';
export 'formats.dart';
import 'package:flutter/material.dart';
import '../resources/resources.dart';

void snackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(message ?? "")));
}

MaterialColor statusColor(OrderStatus status) {
  MaterialColor color;
  switch (status) {
    case OrderStatus.pending:
      color = Colors.yellow;
      break;
    case OrderStatus.completed:
      color = Colors.green;
      break;
    case OrderStatus.cancelled:
      color = Colors.red;
      break;
    case OrderStatus.shipping:
      color = Colors.teal;
      break;
  }
  return color;
}
