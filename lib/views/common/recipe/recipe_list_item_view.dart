import 'package:flutter/material.dart';
import 'package:frontend/models/recipe_model.dart';

class DishListItemView extends StatelessWidget {
  final RecipeModel dish;

  const DishListItemView({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.network(dish.url),
      Positioned(
          right: 2,
          bottom: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [Text(dish.title), Text(dish.description)],
          ))
    ]);
  }
}
