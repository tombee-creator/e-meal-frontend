import 'package:flutter/material.dart';
import 'package:emeal_app/models/meal.dart';
import 'package:emeal_app/views/home/components/meal/meal_list_item_view.dart';

class MealListView extends StatelessWidget {
  final List<Meal> meals;

  const MealListView({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12.0),
      children: meals
          .map((recipe) => SizedBox(
                height: 100,
                child: MealListItemView(recipe: recipe),
              ))
          .toList(),
    );
  }
}
