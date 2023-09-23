import 'package:emeal_app/models/ingredient/ingredient.dart';
import 'package:emeal_app/models/ingredient/used_ingredient_info.dart';
import 'package:emeal_app/views/home/components/ingredient/ingredient_list_item_view.dart';
import 'package:flutter/material.dart';

class IngredientListView extends StatelessWidget {
  final List<Ingredient> ingredients;
  final List<UsedIngredientPostInfo> selected;

  const IngredientListView(
      {super.key, required this.ingredients, required this.selected});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) {
          final ingredient = ingredients[index];
          final count = getUsedIngredientCount(ingredient);
          return IngredientListItemView(ingredient: ingredient, count: count);
        },
        itemCount: ingredients.length);
  }

  int getUsedIngredientCount(Ingredient ingredient) {
    final items = selected.where((item) => item.ingredient.id == ingredient.id);
    if (items.isEmpty) {
      return 0;
    } else {
      return items.first.count;
    }
  }
}
