import 'package:emeal_app/models/ingredient/ingredient.dart';
import 'package:emeal_app/views/home/components/ingredient/ingredient_list_item_view.dart';
import 'package:flutter/material.dart';

class IngredientListView extends StatelessWidget {
  final List<Ingredient> ingredients;
  final List<Ingredient> selected;

  const IngredientListView(
      {super.key, required this.ingredients, required this.selected});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          final ingredient = ingredients[index];
          final count =
              selected.where((item) => item.id == ingredient.id).length;
          return IngredientListItemView(ingredient: ingredient, count: count);
        },
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemCount: ingredients.length);
  }
}
