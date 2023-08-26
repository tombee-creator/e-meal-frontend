import 'package:emeal_app/models/ingredient.dart';
import 'package:emeal_app/views/home/components/ingredient/ingredient_view.dart';
import 'package:emeal_app/views/home/components/meal-preps/meal_preps_view.dart';
import 'package:emeal_app/views/home/components/meal/meal_view.dart';
import 'package:flutter/material.dart';

class MealTabBarView extends StatefulWidget {
  const MealTabBarView({super.key});

  @override
  State<StatefulWidget> createState() => _MealTabBarViewState();
}

class _MealTabBarViewState extends State<MealTabBarView> {
  List<Ingredient> selectedIngredients = [];

  @override
  Widget build(BuildContext context) {
    final links = ["/ingredients", "/preps", "/meals"];
    return Stack(children: [
      TabBarView(children: [
        IngredientView(
            selected: selectedIngredients,
            onSelected: (ingredient) {
              setState(() => selectedIngredients.add(ingredient));
            },
            onRemove: (ingredient) {
              setState(() {
                selectedIngredients = selectedIngredients
                    .where((item) => item.id != ingredient.id)
                    .toList();
              });
            }),
        const MealPrepView(),
        const MealView(),
      ]),
      Positioned(
          right: 20.0,
          bottom: 20.0,
          child: SizedBox(
              width: 64,
              height: 64,
              child: FloatingActionButton(
                  child: const Icon(Icons.post_add),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                        links[DefaultTabController.of(context).index],
                        arguments: {
                          'ingredients': selectedIngredients,
                        });
                  })))
    ]);
  }
}
