import 'package:emeal_app/models/ingredient/ingredient.dart';
import 'package:emeal_app/models/ingredient/used_ingredient_info.dart';
import 'package:emeal_app/views/home/components/ingredient/form/ingredient_form.dart';
import 'package:emeal_app/views/home/components/meal-tab/meal_tab_bar_view.dart';
import 'package:flutter/material.dart';

class IngredientSelectListView extends StatefulWidget {
  final List<Ingredient> ingredients;
  final List<UsedIngredientPostInfo> selected;

  const IngredientSelectListView(
      {super.key, required this.ingredients, required this.selected});

  @override
  State<StatefulWidget> createState() => IngredientSelectListViewState();
}

class IngredientSelectListViewState extends State<IngredientSelectListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          final ingredient = widget.ingredients[index];
          final isChecked = widget.selected
              .where((item) => item.ingredient.id == ingredient.id)
              .isNotEmpty;
          return IngredientForm(
              isChecked: isChecked,
              ingredient: ingredient,
              onCheckboxChanged: (item) {
                if (isChecked) {
                  onRemove(context, item);
                } else {
                  onSelected(context, item);
                }
              });
        },
        itemCount: widget.ingredients.length,
        separatorBuilder: (BuildContext context, int index) => const Divider());
  }

  void onSelected(BuildContext context, Ingredient item) {
    final currentState = context.findAncestorStateOfType<MealTabBarViewState>();
    currentState?.chooseIngredient(item);
  }

  void onRemove(BuildContext context, Ingredient ingredient) {
    final currentState = context.findAncestorStateOfType<MealTabBarViewState>();
    currentState?.clearSelectedIngredients(ingredient);
  }
}
