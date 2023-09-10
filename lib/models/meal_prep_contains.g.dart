// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_prep_contains.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealPrepContains _$MealPrepContainsFromJson(Map<String, dynamic> json) =>
    MealPrepContains(
      json['id'] as String,
      FirebaseUserConverter.fromJson(json['user'] as Map<String, dynamic>),
      MealConverter.fromJson(json['meal'] as Map<String, dynamic>),
      MealPrepConverter.fromJson(json['meal_prep'] as Map<String, dynamic>),
      json['count'] as int,
      DateTime.parse(json['created'] as String).toLocal(),
      DateTime.parse(json['updated'] as String).toLocal(),
    );

Map<String, dynamic> _$MealPrepContainsToJson(MealPrepContains instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': FirebaseUserConverter.toJson(instance.user),
      'meal': MealConverter.toJson(instance.meal),
      'meal_prep': MealPrepConverter.toJson(instance.mealPrep),
      'count': instance.count,
      'created': instance.created.toIso8601String(),
      'updated': instance.updated.toIso8601String(),
    };
