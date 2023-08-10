import 'package:flutter/material.dart';

import '../../../models/recipe_model.dart';
import 'recipe_loading_view.dart';
import 'recipe_list_item_view.dart';

class RecipeListView extends StatelessWidget {
  final Future<List<RecipeModel>> future;

  const RecipeListView({super.key, required this.future});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: FutureBuilder(
            future: future,
            builder: ((context, snapshot) {
              final data = snapshot.data;
              if (data == null) {
                return GridView.count(
                    crossAxisCount: 3,
                    children: List.generate(9, (index) => index)
                        .map((index) => const DishLoadingView())
                        .toList());
              }
              return GridView.count(
                cacheExtent: 1000,
                crossAxisCount: 3,
                children:
                    data.map((dish) => DishListItemView(dish: dish)).toList(),
              );
            })));
  }
}
