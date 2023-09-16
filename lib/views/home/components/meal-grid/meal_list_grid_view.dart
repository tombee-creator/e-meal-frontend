import 'package:emeal_app/models/meal/meal.dart';
import 'package:emeal_app/views/home/components/meal-grid/meal_list_grid_item_view.dart';
import 'package:emeal_app/views/home/components/meal-grid/meal_loading_view.dart';
import 'package:flutter/material.dart';

class MealListGridView extends StatelessWidget {
  final Future<List<Meal>> future;

  const MealListGridView({super.key, required this.future});

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
                    .map((index) => const MealLoadingView())
                    .toList());
          }
          return GridView.count(
            cacheExtent: 1000,
            crossAxisCount: 3,
            mainAxisSpacing: 2.0,
            crossAxisSpacing: 2.0,
            children:
                data.map((meal) => MealListGridItemView(meal: meal)).toList(),
          );
        }));
  }
}
