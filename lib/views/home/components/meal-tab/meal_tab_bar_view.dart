import 'package:emeal_app/models/ingredient/ingredient.dart';
import 'package:emeal_app/models/ingredient/used_ingredient_info.dart';
import 'package:emeal_app/services/database.dart';
import 'package:emeal_app/services/emeal_crud_api.dart';
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
  late List<UsedIngredientPostInfo> selected;

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
            selected: selected,
            isFetch: isFetch),
        IngredientView(
            categories: const [Category.prep],
            selected: selected,
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
                          'ingredients': selected,
                          'category':
                              categories[DefaultTabController.of(context).index]
                        });
                    setState(initSelectedItems);
                  })))
    ]);
  }

  void initSelectedItems() {
    isFetch = true;
    selected = <UsedIngredientPostInfo>[];
  }

  void chooseIngredient(Ingredient ingredient) {
    setState(() {
      final selectedItems = selected;
      final items = selectedItems
          .where((item) => item.ingredient.id == ingredient.id)
          .toList();
      if (items.isEmpty) {
        selectedItems.add(UsedIngredientPostInfo(
            ingredient: ingredient, isUsedUp: false, count: 1));
      } else {
        final item = items.first;
        item.count++;
      }
      selected = selectedItems;
      isFetch = false;
    });
  }

  void useUpIngredient(Ingredient ingredient) {
    setState(() {
      final items = selected
          .where((item) => item.ingredient.id == ingredient.id)
          .toList();
      if (items.isNotEmpty) {
        final item = items.first;
        item.isUsedUp = true;
      }
      isFetch = false;
    });
  }

  void clearSelectedIngredients(Ingredient ingredient) {
    setState(() {
      selected = selected
          .where((item) => item.ingredient.id != ingredient.id)
          .toList();
      isFetch = false;
    });
  }

  Future deleteIngredient(Ingredient ingredient) async {
    final statusCode = await Database()
        .provider<Ingredient>(
            EMealCrudApi(Ingredient.collection, Ingredient.fromJson))
        .delete(ingredient.id);
    if (statusCode == 204) {
      setState(() {
        initSelectedItems();
      });
    }
  }
}
