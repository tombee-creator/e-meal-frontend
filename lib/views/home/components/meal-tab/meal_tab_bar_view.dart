import 'package:emeal_app/models/ingredient/ingredient.dart';
import 'package:emeal_app/views/home/components/ingredient/ingredient_view.dart';
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    setState(initSelectedItems);
  }

  @override
  Widget build(BuildContext context) {
    final links = ["/ingredients", "/ingredients", "/meals"];
    final categories = [Category.ingredient, Category.prep, null];
    return Stack(children: [
      TabBarView(children: [
        IngredientView(
            categories: const [Category.ingredient, Category.gift],
            selected: ingredients,
            isFetch: isFetch),
        IngredientView(
            categories: const [Category.prep],
            selected: ingredients,
            isFetch: isFetch),
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
                          'category':
                              categories[DefaultTabController.of(context).index]
                        });
                    setState(initSelectedItems);
                  })))
    ]);
  }

  void initSelectedItems() {
    isFetch = true;
    ingredients = [];
  }

  void chooseIngredient(Ingredient ingredient) {
    setState(() {
      ingredients.add(ingredient);
      isFetch = false;
    });
  }

  void clearSelectedIngredients(Ingredient ingredient) {
    setState(() {
      ingredients =
          ingredients.where((item) => item.id != ingredient.id).toList();
    });
  }
}
