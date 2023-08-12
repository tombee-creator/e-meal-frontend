import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/models/converters/user_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recipe.g.dart';

@JsonSerializable()
class Recipe {
  @JsonKey(includeFromJson: true, includeToJson: false)
  final String id;

  @JsonKey(fromJson: UserConverter.fromJson, toJson: UserConverter.toJson)
  final User user;

  final String title;

  final String description;

  final String url;

  Recipe(this.id, this.user, this.title, this.description, this.url);

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeToJson(this);
}
