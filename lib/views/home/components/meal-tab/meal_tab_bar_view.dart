import 'package:emeal_app/models/ingredient.dart';
import 'package:emeal_app/models/meal_prep.dart';
import 'package:emeal_app/views/home/components/ingredient/ingredient_view.dart';
import 'package:emeal_app/views/home/components/meal-preps/meal_preps_view.dart';
import 'package:emeal_app/views/home/components/meal/meal_view.dart';
import 'package:flutter/material.dart';

class MealTabBarView extends StatefulWidget {
  const MealTabBarView({super.key});

  @override
  State<StatefulWidget> createState() => MealTabBarViewState();
}

class MealTabBarViewState extends State<MealTabBarView> {
  late bool isFetch;
  late List<Ingredient> ingredients;
  late List<MealPrep> mealPreps;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    setState(initSelectedItems);
  }

  @override
  Widget build(BuildContext context) {
    final links = ["/ingredients", "/preps", "/meals"];
    return Stack(children: [
      TabBarView(children: [
        IngredientView(
            selected: ingredients,
            onSelected: (ingredient) {
              setState(() => ingredients.add(ingredient));
            },
            onRemove: (ingredient) {
              setState(() {
                ingredients = ingredients
                    .where((item) => item.id != ingredient.id)
                    .toList();
              });
            },
            isFetch: isFetch),
        MealPrepView(selected: mealPreps, isFetch: isFetch),
        MealView(isFetch: isFetch),
      ]),
      Positioned(
          right: 20.0,
          bottom: 20.0,
          child: SizedBox(
              width: 64,
              height: 64,
              child: FloatingActionButton(
                  child: const Icon(Icons.post_add),
                  onPressed: () async {
                    await Navigator.of(context).pushNamed(
                        links[DefaultTabController.of(context).index],
                        arguments: {
                          'ingredients': ingredients,
                          'meal_preps': mealPreps
                        });
                    setState(initSelectedItems);
                  })))
    ]);
  }

  void initSelectedItems() {
    isFetch = true;
    ingredients = [];
    mealPreps = [];
  }

  void chooseIngredient(Ingredient ingredient) {
    setState(() {
      ingredients.add(ingredient);
      isFetch = false;
    });
  }

  void chooseMealPrep(MealPrep prep) {
    setState(() {
      mealPreps.add(prep);
      isFetch = false;
    });
  }

  void clearSelectedIngredients(Ingredient ingredient) {
    setState(() {
      ingredients =
          ingredients.where((item) => item.id != ingredient.id).toList();
    });
  }

  void clearSelectedMealPreps(MealPrep prep) {
    setState(() {
      mealPreps = mealPreps.where((item) => item.id != prep.id).toList();
    });
  }
}
