import 'package:emeal_app/models/converters/ingredient_converter.dart';
import 'package:emeal_app/models/converters/meal_prep_converter.dart';
import 'package:emeal_app/models/converters/user_converter.dart';
import 'package:emeal_app/models/ingredient.dart';
import 'package:emeal_app/models/meal.dart';
import 'package:emeal_app/models/meal_prep.dart';
import 'package:emeal_app/services/database.dart';
import 'package:emeal_app/services/firestore_crud_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meal_prep_contains.g.dart';

@JsonSerializable()
class MealPrepContains {
  static const collection = "meal_prep_contains";

  final String id;

  @JsonKey(fromJson: UserConverter.fromJson, toJson: UserConverter.toJson)
  final User user;

  @JsonKey(
      fromJson: IngredientConverter.fromJson,
      toJson: IngredientConverter.toJson)
  final Meal? meal;

  @JsonKey(
      fromJson: MealPrepConverter.fromJson, toJson: MealPrepConverter.toJson)
  final MealPrep? mealPrep;

  final int count;

  final DateTime created;

  final DateTime updated;

  MealPrepContains(this.id, this.user, this.meal, this.mealPrep, this.count,
      this.created, this.updated);

  static Future<MealPrepContains> fromJson(Map<String, dynamic> json) =>
      _$MealPrepContainsFromJson(json);

  Map<String, dynamic> toJson() => _$MealPrepContainsToJson(this);
}
