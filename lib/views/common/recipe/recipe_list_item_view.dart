import 'package:flutter/material.dart';
import 'package:frontend/models/recipe_model.dart';
import 'package:frontend/views/pages/recipe_page.dart';

class DishListItemView extends StatelessWidget {
  final RecipeModel dish;

  const DishListItemView({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => RecipePage(title: "つみたべ", id: dish.id)));
        },
        child: Stack(children: [
          Image.network(dish.url),
          Positioned(
              right: 2,
              bottom: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [Text(dish.title), Text(dish.description)],
              ))
        ]));
  }
}
