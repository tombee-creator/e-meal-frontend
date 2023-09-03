import 'package:emeal_app/models/converters/firebase_user_converter.dart';
import 'package:emeal_app/models/firebase_user.dart';
import 'package:emeal_app/models/meal_prep.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meal.g.dart';

@JsonSerializable()
class Meal {
  static const collection = "recipes";

  final String id;

  @JsonKey(
      fromJson: FirebaseUserConverter.fromJson,
      toJson: FirebaseUserConverter.toJson)
  final FirebaseUser user;

  final String comment;

  final String url;

  final double cost;

  final DateTime created;

  final DateTime updated;

  final List<MealPrep> preps;

  Meal(this.id, this.user, this.comment, this.url, this.cost, this.created,
      this.updated, this.preps);

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);

  Map<String, dynamic> toJson() => _$MealToJson(this);
}
