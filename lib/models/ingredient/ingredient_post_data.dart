import 'dart:convert';

import 'package:emeal_app/models/ingredient/ingredient.dart';
import 'package:emeal_app/models/ingredient/used_ingredient_info.dart';

class IngredientPostData extends Ingredient {
  List<UsedIngredientPostInfo> recipe;
  IngredientPostData(
      super.id,
      super.user,
      super.name,
      super.url,
      super.cost,
      super.times,
      super.category,
      super.isUsedUp,
      super.created,
      super.updated,
      super.usedCount,
      this.recipe);

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data["recipe"] = json.encode(recipe.map((e) => e.toJson()).toList());
    return data;
  }
}
