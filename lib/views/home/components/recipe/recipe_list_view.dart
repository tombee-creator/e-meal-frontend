import 'package:flutter/material.dart';
import 'package:frontend/models/recipe.dart';

import 'recipe_loading_view.dart';
import 'recipe_list_item_view.dart';

class RecipeListView extends StatelessWidget {
  final Future<List<Recipe>> future;

  const RecipeListView({super.key, required this.future});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: ((context, snapshot) {
          final data = snapshot.data;
          if (data == null) {
            return GridView.count(
                crossAxisCount: 3,
                children: List.generate(9, (index) => index)
                    .map((index) => const RecipeLoadingView())
                    .toList());
          }
          return GridView.count(
            childAspectRatio: 0.6,
            cacheExtent: 1000,
            crossAxisCount: 3,
            children: data
                .map((recipe) => RecipeListItemView(recipe: recipe))
                .toList(),
          );
        }));
  }
}
