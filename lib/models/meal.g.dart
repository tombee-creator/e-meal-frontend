// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Meal _$MealFromJson(Map<String, dynamic> json) => Meal(
      json['id'] as String,
      FirebaseUser.fromJson(json['user'] as Map<String, dynamic>),
      json['comment'] as String,
      json['url'] as String,
      (json['cost'] as num).toDouble(),
      DateTime.parse(json['created'] as String),
      DateTime.parse(json['updated'] as String),
    );

Map<String, dynamic> _$MealToJson(Meal instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'comment': instance.comment,
      'url': instance.url,
      'cost': instance.cost,
      'created': instance.created.toIso8601String(),
      'updated': instance.updated.toIso8601String(),
    };
