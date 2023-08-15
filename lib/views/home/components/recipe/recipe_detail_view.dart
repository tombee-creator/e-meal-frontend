import 'package:flutter/material.dart';
import 'package:tsumitabe_app/models/recipe.dart';

class RecipeDetailView extends StatelessWidget {
  final Recipe recipe;

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
