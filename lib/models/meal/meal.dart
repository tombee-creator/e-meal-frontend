import 'dart:convert' show json;

import 'package:emeal_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:emeal_app/models/converters/firebase_user_converter.dart';
import 'package:emeal_app/models/firebase_user/firebase_user.dart';
import 'package:emeal_app/models/ingredient/ingredient.dart';
import 'package:emeal_app/views/helper/utils/date_formatter.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meal.g.dart';

@JsonSerializable()
class Meal {
  static const collection = "recipes";

  final String id;

  @JsonKey(
      fromJson: FirebaseUserConverter.fromJson,
      toJson: FirebaseUserConverter.toJson)
  final FirebaseUser user;

  final String comment;

  final String url;

  final double cost;

  final DateTime created;

  final DateTime updated;

  final List<Ingredient> preps;

  String createdText(BuildContext context) => DateFormatter().format(created);
  String costText(BuildContext context) =>
      "${S.of(context).list_item_label_COST}${NumberFormat.compactSimpleCurrency().format(cost)}";

  Meal(this.id, this.user, this.comment, this.url, this.cost, this.created,
      this.updated, this.preps);

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);

  Map<String, dynamic> toJson() => _$MealToJson(this);
}
