import 'package:emeal_app/models/converters/firebase_user_converter.dart';
import 'package:emeal_app/models/firebase_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meal_prep.g.dart';

@JsonSerializable()
class MealPrep {
  static const collection = "preps";

  final String id;

  @JsonKey(
      fromJson: FirebaseUserConverter.fromJson,
      toJson: FirebaseUserConverter.toJson)
  final FirebaseUser user;

  final String name;

  final String url;

  final double cost;

  final int times;

  @JsonKey(name: "is_used_up")
  final bool isUsedUp;

  final DateTime created;

  final DateTime updated;

  @JsonKey(name: "used_count")
  final int usedCount;

  MealPrep usedUp() => MealPrep(id, user, name, url, cost, times, true, created,
      DateTime.now(), usedCount);

  factory MealPrep.fromJson(Map<String, dynamic> json) =>
      _$MealPrepFromJson(json);

  MealPrep(this.id, this.user, this.name, this.url, this.cost, this.times,
      this.isUsedUp, this.created, this.updated, this.usedCount);

  Map<String, dynamic> toJson() => _$MealPrepToJson(this);
}
