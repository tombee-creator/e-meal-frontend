import 'package:flutter/material.dart';
import 'package:frontend/models/recipe.dart';
import 'package:frontend/views/pages/recipe_page.dart';

class RecipeListItemView extends StatelessWidget {
  final Recipe recipe;

  const RecipeListItemView({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => RecipePage(title: "つみたべ", id: recipe.id)));
        },
        child: Card(
            child: Column(children: [
          Image.network(recipe.url),
          Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [Text(recipe.title), Text(recipe.description)],
              ))
        ])));
  }
}
