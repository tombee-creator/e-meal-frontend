// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prep_ingredient_relationship.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrepIngredientRelation _$PrepIngredientRelationFromJson(
        Map<String, dynamic> json) =>
    PrepIngredientRelation(
      json['id'] as String,
      FirebaseUserConverter.fromJson(json['user'] as Map<String, dynamic>),
      IngredientConverter.fromJson(json['ingredient'] as Map<String, dynamic>),
      MealPrepConverter.fromJson(json['meal_prep'] as Map<String, dynamic>),
      json['count'] as int,
      DateTime.parse(json['created'] as String),
      DateTime.parse(json['updated'] as String),
    );

Map<String, dynamic> _$PrepIngredientRelationToJson(
        PrepIngredientRelation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': FirebaseUserConverter.toJson(instance.user),
      'ingredient': IngredientConverter.toJson(instance.ingredient),
      'meal_prep': MealPrepConverter.toJson(instance.mealPrep),
      'count': instance.count,
      'created': instance.created.toIso8601String(),
      'updated': instance.updated.toIso8601String(),
    };
