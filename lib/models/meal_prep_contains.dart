import 'package:emeal_app/models/converters/firebase_user_converter.dart';
import 'package:emeal_app/models/converters/meal_converter.dart';
import 'package:emeal_app/models/converters/meal_prep_converter.dart';
import 'package:emeal_app/models/firebase_user.dart';
import 'package:emeal_app/models/meal.dart';
import 'package:emeal_app/models/meal_prep.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meal_prep_contains.g.dart';

@JsonSerializable()
class MealPrepContains {
  static const collection = "meal_prep_contains";

  final String id;

  @JsonKey(
      fromJson: FirebaseUserConverter.fromJson,
      toJson: FirebaseUserConverter.toJson)
  final FirebaseUser user;

  @JsonKey(fromJson: MealConverter.fromJson, toJson: MealConverter.toJson)
  final Meal meal;

  @JsonKey(
      name: "meal_prep",
      fromJson: MealPrepConverter.fromJson,
      toJson: MealPrepConverter.toJson)
  final MealPrep mealPrep;

  final int count;

  final DateTime created;

  final DateTime updated;

  MealPrepContains(this.id, this.user, this.meal, this.mealPrep, this.count,
      this.created, this.updated);

  static MealPrepContains fromJson(Map<String, dynamic> json) =>
      _$MealPrepContainsFromJson(json);

  Map<String, dynamic> toJson() => _$MealPrepContainsToJson(this);
}
