import 'package:emeal_app/generated/l10n.dart';
import 'package:emeal_app/models/converters/category_converter.dart';
import 'package:emeal_app/models/converters/firebase_user_converter.dart';
import 'package:emeal_app/models/firebase_user/firebase_user.dart';
import 'package:emeal_app/views/helper/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ingredient.g.dart';

enum Category { ingredient, prep, gift }

@JsonSerializable()
class Ingredient {
  static const collection = "ingredients";

  final String id;

  @JsonKey(
      fromJson: FirebaseUserConverter.fromJson,
      toJson: FirebaseUserConverter.toJson)
  final FirebaseUser user;

  String name;
  double cost;

  final String url;

  final int times;

  final Category category;

  @JsonKey(name: "is_used_up")
  final bool isUsedUp;

  final DateTime created;

  final DateTime updated;

  @JsonKey(name: "used_count")
  final int usedCount;

  String displayCreatedText(BuildContext context) =>
      "${S.of(context).list_item_label_CREATED}${DateFormatter().format(created, type: DateFormatType.listIngredientItem)}";

  String displayCostText(BuildContext context) {
    return "${S.of(context).list_item_label_COST}${NumberFormat.compactSimpleCurrency().format(cost)}";
  }

  String displayUsageText(BuildContext context, {int current = 0}) {
    if (current == 0) {
      return "${S.of(context).list_item_label_USAGE}$usedCount";
    }
    return "${S.of(context).list_item_label_USAGE}$usedCount → ${usedCount + current}";
  }

  Widget categoryWidget(BuildContext context, {TextStyle? style}) {
    switch (category) {
      case Category.ingredient:
        return Chip(
            label: Text(S.of(context).category_label_INGREDIENT,
                style: style, overflow: TextOverflow.ellipsis));
      case Category.gift:
        return Chip(
            label: Text(S.of(context).category_label_GIFT,
                style: style, overflow: TextOverflow.ellipsis));
      case Category.prep:
        return Chip(
            label: Text(S.of(context).category_label_MEAL_PREP,
                style: style, overflow: TextOverflow.ellipsis));
    }
  }

  Ingredient(this.id, this.user, this.name, this.url, this.cost, this.times,
      this.category, this.isUsedUp, this.created, this.updated, this.usedCount);

  Ingredient usedUp() => Ingredient(id, user, name, url, cost, times, category,
      true, created, DateTime.now(), usedCount);

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientToJson(this);
}
