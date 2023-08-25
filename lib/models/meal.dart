import 'package:firebase_auth/firebase_auth.dart';
import 'package:emeal_app/models/converters/user_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meal.g.dart';

@JsonSerializable()
class Meal {
  final String id;

  @JsonKey(fromJson: UserConverter.fromJson, toJson: UserConverter.toJson)
  final User user;

  final String comment;

  final String url;

  final double cost;

  final DateTime created;

  final DateTime updated;

  Meal(this.id, this.user, this.comment, this.url, this.cost, this.created,
      this.updated);

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);

  Map<String, dynamic> toJson() => _$MealToJson(this);
}
