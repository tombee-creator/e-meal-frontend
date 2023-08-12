// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recipe _$RecipeFromJson(Map<String, dynamic> json) => Recipe(
      json['id'] as String,
      UserConverter.fromJson(json['user'] as String),
      json['title'] as String,
      json['description'] as String,
      json['url'] as String,
    );

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
      'user': UserConverter.toJson(instance.user),
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
    };
