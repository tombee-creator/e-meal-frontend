import 'dart:convert';

import 'package:emeal_app/models/ingredient/used_ingredient_info.dart';
import 'package:emeal_app/models/meal/meal.dart';

class MealPostData extends Meal {
  final List<UsedIngredientPostInfo> recipe;

  MealPostData(super.id, super.user, super.comment, super.url, super.cost,
      super.created, super.updated, super.preps, this.recipe);

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data["menu"] = json.encode(recipe.map((e) => e.toJson()).toList());
    return data;
  }
}
