import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toFormattedString(
      {String format = 'yyyy/MM/dd HH:mm', locale = "ja_JP"}) {
    var formatter = DateFormat(format, locale);
    var formatted = formatter.format(this);
    return formatted;
  }
}
