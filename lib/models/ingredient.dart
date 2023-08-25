import 'package:emeal_app/models/converters/user_converter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ingredient.g.dart';

@JsonSerializable()
class Ingredient {
  static const collection = "ingredients";

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

  Ingredient(this.id, this.user, this.name, this.url, this.cost, this.times,
      this.isUsedUp, this.created, this.updated);

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientToJson(this);
}
