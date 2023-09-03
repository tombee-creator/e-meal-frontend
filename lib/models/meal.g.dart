// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Meal _$MealFromJson(Map<String, dynamic> json) => Meal(
      json['id'] as String,
      FirebaseUserConverter.fromJson(json['user'] as Map<String, dynamic>),
      json['comment'] as String,
      json['url'] as String,
      (json['cost'] as num).toDouble(),
      DateTime.parse(json['created'] as String),
      DateTime.parse(json['updated'] as String),
      (json['preps'] as List<dynamic>)
          .map((e) => MealPrep.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MealToJson(Meal instance) => <String, dynamic>{
      'id': instance.id,
      'user': FirebaseUserConverter.toJson(instance.user),
      'comment': instance.comment,
      'url': instance.url,
      'cost': instance.cost.toString(),
      'created': instance.created.toIso8601String(),
      'updated': instance.updated.toIso8601String(),
      'preps':
          json.encode(instance.preps.map((prep) => prep.toJson()).toList()),
    };
