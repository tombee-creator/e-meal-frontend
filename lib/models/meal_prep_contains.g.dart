// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_prep_contains.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealPrepContains _$MealPrepContainsFromJson(Map<String, dynamic> json) =>
    MealPrepContains(
      json['id'] as String,
      FirebaseUser.fromJson(json['user'] as Map<String, dynamic>),
      Meal.fromJson(json['meal'] as Map<String, dynamic>),
      MealPrep.fromJson(json['mealPrep'] as Map<String, dynamic>),
      json['count'] as int,
      DateTime.parse(json['created'] as String),
      DateTime.parse(json['updated'] as String),
    );

Map<String, dynamic> _$MealPrepContainsToJson(MealPrepContains instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'meal': instance.meal,
      'mealPrep': instance.mealPrep,
      'count': instance.count,
      'created': instance.created.toIso8601String(),
      'updated': instance.updated.toIso8601String(),
    };
