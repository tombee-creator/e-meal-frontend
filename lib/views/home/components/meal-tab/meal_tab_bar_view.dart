import 'package:emeal_app/models/ingredient/ingredient.dart';
import 'package:emeal_app/models/ingredient/used_ingredient_info.dart';
import 'package:emeal_app/services/database.dart';
import 'package:emeal_app/services/emeal_crud_api.dart';
import 'package:emeal_app/views/common/alert_view.dart';
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
    final links = ["/ingredients", "/meals"];
    final categories = [Category.ingredient, null];
    return Stack(children: [
      TabBarView(children: [
        IngredientView(selected: selected, isFetch: isFetch),
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
      selected.add(UsedIngredientPostInfo(
          ingredient: ingredient, isUsedUp: false, count: 1));
    });
  }

  void useUpIngredient(Ingredient ingredient) {
    final items =
        selected.where((item) => item.ingredient.id == ingredient.id).toList();
    if (items.isNotEmpty) {
      setState(() {
        final item = items.first;
        item.isUsedUp = true;
        isFetch = false;
      });
    } else {
      AlertView()
          .show(context, body: "${ingredient.name}を「使い切り」に変更しますか？")
          .then((result) async {
        if (result) {
          final item = await Database()
              .provider(
                  EMealCrudApi(Ingredient.collection, Ingredient.fromJson))
              .put(ingredient.id, ingredient.usedUp(),
                  (instance) => instance.toJson());
          if (item != null) {
            setState(() {
              initSelectedItems();
            });
          }
        }
      });
    }
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
    final name = ingredient.name;
    final result =
        await AlertView().show(context, body: "$nameを素材一覧から削除してもよろしいですか？");
    if (result) {
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
}
