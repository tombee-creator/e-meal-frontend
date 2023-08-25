import 'package:flutter/material.dart';
import 'package:emeal_app/models/meal.dart';
import 'package:emeal_app/views/helper/image/image_helper.dart';
import 'package:emeal_app/views/pages/recipe_page.dart';

class RecipeListItemView extends StatelessWidget {
  final Meal recipe;

  const RecipeListItemView({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => MealPage(title: "e-Meal", id: recipe.id)));
        },
        child: AspectRatio(
            aspectRatio: 1.0, child: ImageHelper.image(recipe.url)));
  }
}
