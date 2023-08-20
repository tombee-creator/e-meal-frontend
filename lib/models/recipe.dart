import 'package:firebase_auth/firebase_auth.dart';
import 'package:emeal_app/models/converters/user_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recipe.g.dart';

@JsonSerializable()
class Recipe {
  final String id;

  @JsonKey(fromJson: UserConverter.fromJson, toJson: UserConverter.toJson)
  final User user;

  final String comment;

  final String url;

  final double cost;

  final DateTime created;

  final DateTime updated;

  Recipe(this.id, this.user, this.comment, this.url, this.cost, this.created,
      this.updated);

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeToJson(this);
}
