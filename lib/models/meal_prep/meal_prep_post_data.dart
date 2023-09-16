import 'dart:convert' show json;
import 'package:emeal_app/models/meal_prep/meal_prep.dart';
import 'package:emeal_app/models/meal_prep/used_ingredient_data.dart';

class MealPrepPostData extends MealPrep {
  final List<UsedIngredientData> usedItems;

  MealPrepPostData(
      super.id,
      super.user,
      super.name,
      super.url,
      super.cost,
      super.times,
      super.isUsedUp,
      super.created,
      super.updated,
      super.usedCount,
      this.usedItems);

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data["recipe"] =
        json.encode(usedItems.map((item) => item.toJson()).toList());
    return data;
  }
}
