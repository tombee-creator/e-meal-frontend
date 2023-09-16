import 'package:emeal_app/models/converters/firebase_user_converter.dart';
import 'package:emeal_app/models/firebase_user/firebase_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ingredient.g.dart';

@JsonSerializable()
class Ingredient {
  static const collection = "ingredients";

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

  Ingredient(this.id, this.user, this.name, this.url, this.cost, this.times,
      this.isUsedUp, this.created, this.updated, this.usedCount);

  Ingredient usedUp() => Ingredient(id, user, name, url, cost, times, true,
      created, DateTime.now(), usedCount);

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientToJson(this);
}
