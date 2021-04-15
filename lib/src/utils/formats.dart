import 'package:intl/intl.dart';

class Formats {
  static String dateTime(DateTime dateTime) {
    if (dateTime == null) return null;
    return DateFormat('dd-MM-yyyy').add_jm().format(dateTime);
  }

  static String money(int value) {
    if (value == null) return '';
    return NumberFormat().format(value);
  }
}
