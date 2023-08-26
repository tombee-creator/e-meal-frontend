import 'package:emeal_app/models/ingredient.dart';
import 'package:emeal_app/views/home/components/ingredient/ingredient_list_item_view.dart';
import 'package:flutter/material.dart';

class IngredientListView extends StatelessWidget {
  final List<Ingredient> ingredients;
  final List<Ingredient> selected;
  final void Function(Ingredient) onSelected;
  final void Function(Ingredient) onRemove;

  const IngredientListView(
      {super.key,
      required this.ingredients,
      required this.selected,
      required this.onSelected,
      required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12.0),
      children: ingredients.map((ingredient) {
        final count = selected.where((item) => item.id == ingredient.id).length;
        return SizedBox(
          height: 100,
          child: IngredientListItemView(
              ingredient: ingredient,
              count: count,
              onSelected: (ingredient) => onSelected(ingredient),
              onRemove: (ingredient) => onRemove(ingredient)),
        );
      }).toList(),
    );
  }
}
