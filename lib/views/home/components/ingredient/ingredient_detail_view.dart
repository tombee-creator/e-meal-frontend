import 'package:emeal_app/models/ingredient/ingredient.dart';
import 'package:flutter/material.dart';
import 'package:emeal_app/views/helper/image/image_helper.dart';

class IngredientDetailView extends StatelessWidget {
  final Ingredient ingredient;

  const IngredientDetailView({super.key, required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ImageHelper.image(ingredient.url),
      ],
    );
  }
}
