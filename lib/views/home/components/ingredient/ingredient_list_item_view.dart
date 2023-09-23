import 'package:flutter/material.dart';
import 'package:emeal_app/models/ingredient/ingredient.dart';
import 'package:emeal_app/views/home/components/meal-tab/meal_tab_bar_view.dart';

class IngredientListItemView extends StatefulWidget {
  final Ingredient ingredient;
  final int count;

  const IngredientListItemView(
      {super.key, required this.ingredient, required this.count});

  @override
  State<StatefulWidget> createState() => _IngredientListItemViewState();
}

class _IngredientListItemViewState extends State<IngredientListItemView> {
  @override
  Widget build(BuildContext context) {
    final list = <Widget>[];
    list.add(Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(Icons.inventory)),
                  Text(widget.ingredient.name, overflow: TextOverflow.ellipsis)
                ],
              )),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.ingredient.displayCostText(context),
                        style: const TextStyle(fontSize: 12.0)),
                    Text(
                        widget.ingredient
                            .displayUsageText(context, current: widget.count),
                        style: TextStyle(
                            fontSize: 12.0,
                            color: widget.count > 0
                                ? Theme.of(context).colorScheme.primary
                                : null)),
                    Text(widget.ingredient.createdText(context),
                        style: const TextStyle(fontSize: 12.0))
                  ]))
        ]));
    return Card(
        child: InkWell(
            onTap: onTap,
            child: Column(children: [
              ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 120),
                  child: Row(children: list)),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Expanded(
                    child: TextButton(
                        onPressed: () => onRemove(context, widget.ingredient),
                        child: const Text("リセット"))),
                Expanded(
                    child: TextButton(
                        onPressed: () => useUp(context, widget.ingredient),
                        child: const Text("使い切る"))),
                Expanded(
                    child: TextButton(
                        onPressed: () => onDelete(context, widget.ingredient),
                        child: const Text("削除")))
              ])
            ])));
  }

  void onSelected(BuildContext context, Ingredient item) {
    final currentState = context.findAncestorStateOfType<MealTabBarViewState>();
    currentState?.chooseIngredient(item);
  }

  void onRemove(BuildContext context, Ingredient ingredient) {
    final currentState = context.findAncestorStateOfType<MealTabBarViewState>();
    currentState?.clearSelectedIngredients(ingredient);
  }

  void useUp(BuildContext context, Ingredient ingredient) {
    final currentState = context.findAncestorStateOfType<MealTabBarViewState>();
    currentState?.useUpIngredient(ingredient);
  }

  void onDelete(BuildContext context, Ingredient ingredient) {
    final currentState = context.findAncestorStateOfType<MealTabBarViewState>();
    currentState?.deleteIngredient(ingredient);
  }

  void onTap() {
    onSelected(context, widget.ingredient);
  }
}
