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
  @override
  Widget build(BuildContext context) {
    final links = ["/ingredients", "/preps", "/meals"];
    return Stack(
      children: [
        const TabBarView(children: [
          IngredientView(),
          MealPrepView(),
          MealView(),
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
                  Navigator.of(context)
                      .pushNamed(links[DefaultTabController.of(context).index]);
                },
              ),
            ))
      ],
    );
  }
}
