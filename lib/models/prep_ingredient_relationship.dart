import 'package:emeal_app/models/converters/firebase_user_converter.dart';
import 'package:emeal_app/models/converters/ingredient_converter.dart';
import 'package:emeal_app/models/converters/meal_prep_converter.dart';
import 'package:emeal_app/models/firebase_user.dart';
import 'package:emeal_app/models/ingredient.dart';
import 'package:emeal_app/models/meal_prep.dart';
import 'package:json_annotation/json_annotation.dart';

part 'prep_ingredient_relationship.g.dart';

@JsonSerializable()
class PrepIngredientRelation {
  static const collection = "prep_ingredient_releation";

  final String id;

  @FirebaseUserConverter()
  final FirebaseUser user;

  @IngredientConverter()
  final Ingredient ingredient;

  @MealPrepConverter()
  final MealPrep mealPrep;

  final int count;

  final DateTime created;

  final DateTime updated;

  PrepIngredientRelation(this.id, this.user, this.ingredient, this.mealPrep,
      this.count, this.created, this.updated);

  static PrepIngredientRelation fromJson(Map<String, dynamic> json) =>
      _$PrepIngredientRelationFromJson(json);

  Map<String, dynamic> toJson() => _$PrepIngredientRelationToJson(this);
}
