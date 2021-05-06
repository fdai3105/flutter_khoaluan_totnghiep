// Package imports:
import 'package:intl/intl.dart';

class Formats {
  static String dateTime(DateTime dateTime) {
    if (dateTime == null) return '';
    return DateFormat('dd-MM-yyyy').add_jm().format(dateTime);
  }

  static String money(num value) {
    if (value == null) return '';
    return '\$${NumberFormat().format(value)}';
  }
}
