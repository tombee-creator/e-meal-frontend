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
      DateTime.parse(json['create'] as String),
      DateTime.parse(json['update'] as String),
    );

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
      'id': instance.id,
      'user': UserConverter.toJson(instance.user),
      'comment': instance.comment,
      'url': instance.url,
      'cost': instance.cost,
      'create': instance.create.toIso8601String(),
      'update': instance.update.toIso8601String(),
    };
