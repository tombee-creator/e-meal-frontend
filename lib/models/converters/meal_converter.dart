import 'dart:convert';

import 'package:emeal_app/models/meal.dart';
import 'package:json_annotation/json_annotation.dart';

class MealConverter implements JsonConverter<Meal?, String?> {
  const MealConverter();

  @override
  Meal? fromJson(String? text) =>
      Meal.fromJson(json.decode(text ?? "") as Map<String, dynamic>);

  @override
  String? toJson(Meal? object) => object?.id;
}
