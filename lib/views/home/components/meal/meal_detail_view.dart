import 'package:emeal_app/models/meal/meal.dart';
import 'package:flutter/material.dart';
import 'package:emeal_app/views/helper/image/image_helper.dart';

class RecipeDetailView extends StatelessWidget {
  final Meal recipe;

  const RecipeDetailView({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ImageHelper.image(recipe.url),
      ],
    );
  }
}
