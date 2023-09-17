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
    list.add(const AspectRatio(
      aspectRatio: 1.0,
      child: Icon(Icons.inventory, color: Colors.black),
    ));
    list.add(Expanded(
        flex: 5,
        child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.ingredient.name, overflow: TextOverflow.ellipsis),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.ingredient.displayCostText(context),
                            style: const TextStyle(fontSize: 12.0)),
                        Text(
                            widget.ingredient.displayUsageText(context,
                                current: widget.count),
                            style: TextStyle(
                                fontSize: 12.0,
                                color: widget.count > 0
                                    ? Theme.of(context).colorScheme.primary
                                    : null)),
                        Text(widget.ingredient.createdText(context),
                            style: const TextStyle(fontSize: 12.0))
                      ])
                ]))));
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
                      onPressed: (_) {},
                      backgroundColor: Theme.of(context).colorScheme.error,
                      foregroundColor:
                          Theme.of(context).colorScheme.inversePrimary,
                      icon: Icons.remove,
                      label: '削除')
                ]),
            child: Card(child: Row(children: list))));
  }

  void onSelected(BuildContext context, Ingredient item) {
    final currentState = context.findAncestorStateOfType<MealTabBarViewState>();
    currentState?.chooseIngredient(item);
  }

  void onRemove(BuildContext context, Ingredient ingredient) {
    final currentState = context.findAncestorStateOfType<MealTabBarViewState>();
    currentState?.clearSelectedIngredients(ingredient);
  }

  void onTap() {
    final countUsedUp = widget.count + widget.ingredient.usedCount;
    if (countUsedUp >= widget.ingredient.times) {
      onRemove(context, widget.ingredient);
    } else {
      if (countUsedUp < widget.ingredient.times - 1) {
        onSelected(context, widget.ingredient);
      } else {
        onSelected(context, widget.ingredient.usedUp());
      }
    }
  }
}
