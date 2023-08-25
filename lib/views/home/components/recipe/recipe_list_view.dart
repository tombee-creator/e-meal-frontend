import 'package:flutter/material.dart';
import 'package:emeal_app/models/meal.dart';
import 'package:emeal_app/views/home/components/recipe/recipe_list_item_view.dart';
import 'package:emeal_app/views/home/components/recipe/recipe_loading_view.dart';

class RecipeListView extends StatelessWidget {
  final Future<List<Meal>> future;

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
            cacheExtent: 1000,
            crossAxisCount: 3,
            mainAxisSpacing: 2.0,
            crossAxisSpacing: 2.0,
            children: data
                .map((recipe) => RecipeListItemView(recipe: recipe))
                .toList(),
          );
        }));
  }
}
