import 'package:emeal_app/models/converters/user_converter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meal_prep.g.dart';

@JsonSerializable()
class MealPrep {
  static const collection = "preps";

  final String id;

  @JsonKey(fromJson: UserConverter.fromJson, toJson: UserConverter.toJson)
  final User user;

  final String name;

  final String url;

  final double cost;

  final int times;

  final bool isUsedUp;

  final DateTime created;

  final DateTime updated;

  MealPrep usedUp() =>
      MealPrep(id, user, name, url, cost, times, true, created, DateTime.now());

  factory MealPrep.fromJson(Map<String, dynamic> json) =>
      _$MealPrepFromJson(json);

  MealPrep(this.id, this.user, this.name, this.url, this.cost, this.times,
      this.isUsedUp, this.created, this.updated);

  Map<String, dynamic> toJson() => _$MealPrepToJson(this);
}
