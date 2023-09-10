import 'package:emeal_app/views/helper/utils/date_formatter.dart';
import 'package:emeal_app/models/ingredient.dart';
import 'package:emeal_app/views/home/components/meal-tab/meal_tab_bar_view.dart';
import 'package:flutter/material.dart';

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
              Text(widget.ingredient.name),
              Text(DateFormatter().format(widget.ingredient.created))
            ],
          ),
        )));
    if (widget.count > 0) {
      list.add(Padding(
        padding: const EdgeInsets.all(12.0),
        child: CircleAvatar(
          radius: 18.0,
          child: Text(
            "${widget.count}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ));
    }
    return GestureDetector(
        onTap: widget.ingredient.isUsedUp ? null : onTap,
        child: Card(
            color: widget.count > 0
                ? Theme.of(context).colorScheme.background
                : null,
            child: Row(children: list)));
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
