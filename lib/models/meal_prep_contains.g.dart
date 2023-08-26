// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_prep_contains.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Future<MealPrepContains> _$MealPrepContainsFromJson(
    Map<String, dynamic> json) async {
  final meal = await Database()
      .provider(FirestoreCRUDApi<Meal>(Ingredient.collection, Meal.fromJson))
      .get(json['meal']);
  final mealPrep = await Database()
      .provider(
          FirestoreCRUDApi<MealPrep>(MealPrep.collection, MealPrep.fromJson))
      .get(json['meal_prep']);
  return MealPrepContains(
    json['id'] as String,
    UserConverter.fromJson(json['user'] as String),
    meal,
    mealPrep,
    json['count'] as int,
    DateTime.parse(json['created'] as String),
    DateTime.parse(json['updated'] as String),
  );
}

Map<String, dynamic> _$MealPrepContainsToJson(MealPrepContains instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': UserConverter.toJson(instance.user),
      'meal': instance.meal?.id,
      'meal_prep': instance.mealPrep?.id,
      'count': instance.count,
      'created': instance.created.toIso8601String(),
      'updated': instance.updated.toIso8601String(),
    };
