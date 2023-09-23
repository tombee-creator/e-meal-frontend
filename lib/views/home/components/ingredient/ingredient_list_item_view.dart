import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
    list.add(const Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Icon(Icons.inventory)));
    list.add(Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.ingredient.name, overflow: TextOverflow.ellipsis),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
          ])
        ]));
    return GestureDetector(
        onTap: widget.ingredient.isUsedUp ? null : onTap,
        child: Slidable(
            endActionPane: ActionPane(
                extentRatio: 0.6,
                motion: const DrawerMotion(),
                children: [
                  SlidableAction(
                      onPressed: (_) => onRemove(context, widget.ingredient),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor:
                          Theme.of(context).colorScheme.inversePrimary,
                      icon: Icons.clear,
                      label: 'リセット'),
                  SlidableAction(
                      onPressed: (_) {
                        onDelete(context, widget.ingredient);
                      },
                      backgroundColor: Theme.of(context).colorScheme.error,
                      foregroundColor:
                          Theme.of(context).colorScheme.inversePrimary,
                      icon: Icons.remove,
                      label: '削除')
                ]),
            child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 120),
                child: Row(children: list))));
  }

  void onSelected(BuildContext context, Ingredient item) {
    final currentState = context.findAncestorStateOfType<MealTabBarViewState>();
    currentState?.chooseIngredient(item);
  }

  void onRemove(BuildContext context, Ingredient ingredient) {
    final currentState = context.findAncestorStateOfType<MealTabBarViewState>();
    currentState?.clearSelectedIngredients(ingredient);
  }

  void onDelete(BuildContext context, Ingredient ingredient) {
    final currentState = context.findAncestorStateOfType<MealTabBarViewState>();
    currentState?.deleteIngredient(ingredient);
  }

  void onTap() {
    onSelected(context, widget.ingredient);
  }
}
