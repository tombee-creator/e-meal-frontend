import 'dart:convert';

import 'package:emeal_app/models/meal_prep.dart';
import 'package:json_annotation/json_annotation.dart';

class MealPrepConverter implements JsonConverter<MealPrep?, String?> {
  const MealPrepConverter();

  @override
  MealPrep? fromJson(String? text) =>
      MealPrep.fromJson(json.decode(text ?? "") as Map<String, dynamic>);

  @override
  String? toJson(MealPrep? object) => object?.id;
}
