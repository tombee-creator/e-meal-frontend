import 'package:flutter/material.dart';
import 'package:tsumitabe_app/models/recipe.dart';
import 'package:tsumitabe_app/views/helper/image/image_helper.dart';
import 'package:tsumitabe_app/views/pages/recipe_page.dart';

class RecipeListItemView extends StatelessWidget {
  final Recipe recipe;

  const RecipeListItemView({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => RecipePage(title: "e-Meal", id: recipe.id)));
        },
        child: AspectRatio(
            aspectRatio: 1.0, child: ImageHelper.image(recipe.url)));
  }
}
