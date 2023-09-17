import 'package:intl/intl.dart';

enum DateFormatType { listMealItem, listIngredientItem, profileItem, none }

class DateFormatter {
  DateFormatter? _instance;

  factory() => _instance ??= DateFormatter();

  String format(DateTime dateTime,
      {DateFormatType type = DateFormatType.listMealItem}) {
    return switch (type) {
      DateFormatType.listMealItem =>
        "${DateFormat.yMMMMd().format(dateTime)} ${DateFormat.Hm().format(dateTime)}",
      DateFormatType.listIngredientItem => DateFormat.yMMMMd().format(dateTime),
      DateFormatType.profileItem =>
        "${DateFormat.y().format(dateTime)}${DateFormat.M().format(dateTime)}",
      _ => DateFormat().format(dateTime)
    };
  }
}
