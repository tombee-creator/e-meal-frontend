import 'package:emeal_app/models/converters/firebase_user_converter.dart';
import 'package:emeal_app/models/firebase_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ingredient.g.dart';

@JsonSerializable()
class Ingredient {
  static const collection = "ingredients";

  final String id;

  @FirebaseUserConverter()
  final FirebaseUser user;

  final String name;

  final String url;

  final double cost;

  final int times;

  final bool isUsedUp;

  final DateTime created;

  final DateTime updated;

  Ingredient(this.id, this.user, this.name, this.url, this.cost, this.times,
      this.isUsedUp, this.created, this.updated);

  Ingredient usedUp() => Ingredient(
      id, user, name, url, cost, times, true, created, DateTime.now());

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientToJson(this);
}
