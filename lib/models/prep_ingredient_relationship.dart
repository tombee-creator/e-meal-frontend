import 'package:emeal_app/models/converters/ingredient_converter.dart';
import 'package:emeal_app/models/converters/meal_prep_converter.dart';
import 'package:emeal_app/models/converters/user_converter.dart';
import 'package:emeal_app/models/ingredient.dart';
import 'package:emeal_app/models/meal_prep.dart';
import 'package:emeal_app/services/database.dart';
import 'package:emeal_app/services/firestore_crud_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';

part 'prep_ingredient_releation.g.dart';

@JsonSerializable()
class PrepIngredientRelation {
  static const collection = "prep_ingredient_releation";

  final String id;

  @JsonKey(fromJson: UserConverter.fromJson, toJson: UserConverter.toJson)
  final User user;

  @JsonKey(
      fromJson: IngredientConverter.fromJson,
      toJson: IngredientConverter.toJson)
  final Ingredient? ingredient;

  @JsonKey(
      fromJson: MealPrepConverter.fromJson, toJson: MealPrepConverter.toJson)
  final MealPrep? mealPrep;

  final int count;

  final DateTime created;

  final DateTime updated;

  PrepIngredientRelation(this.id, this.user, this.ingredient, this.mealPrep,
      this.count, this.created, this.updated);

  static Future<PrepIngredientRelation> fromJson(Map<String, dynamic> json) =>
      _$PrepIngredientRelationFromJson(json);

  Map<String, dynamic> toJson() => _$PrepIngredientRelationToJson(this);
}
