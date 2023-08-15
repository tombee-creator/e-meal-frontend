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
          AspectRatio(aspectRatio: 1.0, child: Image.network(recipe.url)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                recipe.comment,
                overflow: TextOverflow.ellipsis,
              )
            ],
          )
        ])));
  }
}
