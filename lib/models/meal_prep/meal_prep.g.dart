// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_prep.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealPrep _$MealPrepFromJson(Map<String, dynamic> json) => MealPrep(
      json['id'] as String,
      FirebaseUserConverter.fromJson(json['user'] as Map<String, dynamic>),
      json['name'] as String,
      json['url'] as String,
      (json['cost'] as num).toDouble(),
      (json['times'] as num).toInt(),
      json['is_used_up'] as bool,
      DateTime.parse(json['created'] as String).toLocal(),
      DateTime.parse(json['updated'] as String).toLocal(),
      (json['used_count'] as num).toInt(),
    );

Map<String, dynamic> _$MealPrepToJson(MealPrep instance) => <String, dynamic>{
      'id': instance.id,
      'user': FirebaseUserConverter.toJson(instance.user),
      'name': instance.name,
      'url': instance.url,
      'cost': instance.cost.toString(),
      'times': instance.times.toString(),
      'is_used_up': instance.isUsedUp.toString(),
      'created': instance.created.toIso8601String(),
      'updated': instance.updated.toIso8601String(),
      'used_count': instance.usedCount.toString(),
      'recipe':
          json.encode(instance.recipe?.map((item) => item.toJson()).toList())
    };
