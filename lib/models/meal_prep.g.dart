// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_prep.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealPrep _$MealPrepFromJson(Map<String, dynamic> json) => MealPrep(
      json['id'] as String,
      UserConverter.fromJson(json['user'] as String),
      json['name'] as String,
      json['url'] as String,
      (json['cost'] as num).toDouble(),
      json['times'] as int,
      json['is_used_up'] as bool,
      DateTime.parse(json['created'] as String),
      DateTime.parse(json['updated'] as String),
    );

Map<String, dynamic> _$MealPrepToJson(MealPrep instance) => <String, dynamic>{
      'id': instance.id,
      'user': UserConverter.toJson(instance.user),
      'name': instance.name,
      'url': instance.url,
      'cost': instance.cost,
      'times': instance.times,
      'is_used_up': instance.isUsedUp,
      'created': instance.created.toIso8601String(),
      'updated': instance.updated.toIso8601String(),
    };
