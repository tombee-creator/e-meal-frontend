import 'package:flutter/material.dart';
import 'package:frontend/models/recipe_model.dart';

class RecipeDetailView extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeDetailView({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(recipe.url),
      ],
    );
  }
}
