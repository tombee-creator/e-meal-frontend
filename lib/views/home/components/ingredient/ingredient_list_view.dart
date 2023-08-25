import 'package:emeal_app/models/ingredient.dart';
import 'package:emeal_app/views/home/components/ingredient/ingredient_list_item_view.dart';
import 'package:flutter/material.dart';

class IngredientListView extends StatelessWidget {
  final List<Ingredient> ingredients;

  const IngredientListView({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12.0),
      children: ingredients
          .map((ingredient) => SizedBox(
                height: 120,
                child: IngredientListItemView(ingredient: ingredient),
              ))
          .toList(),
    );
  }
}
