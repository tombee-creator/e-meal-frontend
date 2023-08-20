// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recipe _$RecipeFromJson(Map<String, dynamic> json) => Recipe(
      json['id'] as String,
      UserConverter.fromJson(json['user'] as String),
      json['comment'] as String,
      json['url'] as String,
      (json['cost'] as num).toDouble(),
      DateTime.parse(json['created'] as String),
      DateTime.parse(json['updated'] as String),
    );

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
      'id': instance.id,
      'user': UserConverter.toJson(instance.user),
      'comment': instance.comment,
      'url': instance.url,
      'cost': instance.cost,
      'created': instance.created.toIso8601String(),
      'updated': instance.updated.toIso8601String(),
    };
