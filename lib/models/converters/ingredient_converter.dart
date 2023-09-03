import 'dart:convert';

import 'package:emeal_app/models/ingredient.dart';
import 'package:json_annotation/json_annotation.dart';

class IngredientConverter implements JsonConverter<Ingredient?, String?> {
  const IngredientConverter();

  @override
  Ingredient? fromJson(String? text) =>
      Ingredient.fromJson(json.decode(text ?? "") as Map<String, dynamic>);

  @override
  String? toJson(Ingredient? object) => object?.id;
}
