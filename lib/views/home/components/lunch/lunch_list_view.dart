import 'package:flutter/material.dart';
import 'package:emeal_app/models/recipe.dart';
import 'package:emeal_app/views/home/components/lunch/lunch_list_item_view.dart';

class LunchListView extends StatelessWidget {
  final List<Recipe> recipes;

  const LunchListView({super.key, required this.recipes});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: recipes
          .map((recipe) => SizedBox(
                height: 120,
                child: LunchListItemView(recipe: recipe),
              ))
          .toList(),
    );
  }
}
