import 'package:intl/intl.dart';

enum DateFormatType { listItem, profileItem, none }

class DateFormatter {
  DateFormatter? _instance;

  factory() => _instance ??= DateFormatter();

  String format(DateTime dateTime,
      {DateFormatType type = DateFormatType.listItem}) {
    return switch (type) {
      DateFormatType.listItem =>
        "${DateFormat.yMMMMd().format(dateTime)} ${DateFormat.Hm().format(dateTime)}",
      DateFormatType.profileItem =>
        "${DateFormat.y().format(dateTime)}${DateFormat.M().format(dateTime)}",
      _ => DateFormat().format(dateTime)
    };
  }
}
