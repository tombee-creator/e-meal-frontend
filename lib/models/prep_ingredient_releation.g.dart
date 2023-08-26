// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prep_ingredient_relationship.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Future<PrepIngredientRelation> _$PrepIngredientRelationFromJson(
    Map<String, dynamic> json) async {
  final ingredient = await Database()
      .provider(FirestoreCRUDApi<Ingredient>(
          Ingredient.collection, Ingredient.fromJson))
      .get(json['ingredient']);
  final mealPrep = await Database()
      .provider(
          FirestoreCRUDApi<MealPrep>(MealPrep.collection, MealPrep.fromJson))
      .get(json['meal_prep']);
  return PrepIngredientRelation(
    json['id'] as String,
    UserConverter.fromJson(json['user'] as String),
    ingredient,
    mealPrep,
    json['count'] as int,
    DateTime.parse(json['created'] as String),
    DateTime.parse(json['updated'] as String),
  );
}

Map<String, dynamic> _$PrepIngredientRelationToJson(
        PrepIngredientRelation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': UserConverter.toJson(instance.user),
      'ingredient': instance.ingredient?.id,
      'meal_prep': instance.mealPrep?.id,
      'count': instance.count,
      'created': instance.created.toIso8601String(),
      'updated': instance.updated.toIso8601String(),
    };
