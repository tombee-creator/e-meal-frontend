import 'package:emeal_app/generated/l10n.dart';
import 'package:emeal_app/models/ingredient/ingredient.dart';
import 'package:emeal_app/views/home/components/meal-tab/meal_tab_bar_view.dart';
import 'package:flutter/material.dart';

class IngredientForm extends StatefulWidget {
  final bool isChecked;
  final Ingredient ingredient;
  final void Function(Ingredient) onCheckboxChanged;

  const IngredientForm(
      {super.key,
      required this.isChecked,
      required this.ingredient,
      required this.onCheckboxChanged});

  @override
  State<StatefulWidget> createState() => IngredientFormState();
}

class IngredientFormState extends State<IngredientForm> {
  late Ingredient ingredient;

  @override
  void initState() {
    super.initState();
    ingredient = widget.ingredient;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(children: [
      Row(children: [
        Expanded(
            flex: 1,
            child: Checkbox(
                value: widget.isChecked,
                onChanged: (isChecked) {
                  widget.onCheckboxChanged(ingredient);
                })),
        Expanded(
            flex: 4,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: TextFormField(
                    initialValue: ingredient.name,
                    decoration: InputDecoration(
                        label: Text(S.of(context).list_item_label_NAME)),
                    onChanged: (name) {
                      setState(() {
                        ingredient.name = name;
                      });
                    },
                    style: Theme.of(context).textTheme.labelLarge))),
        Expanded(
            flex: 3,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: TextFormField(
                    initialValue: ingredient.cost.toString(),
                    decoration: InputDecoration(
                        label: Text(S.of(context).list_item_label_COST)),
                    onChanged: (cost) {
                      setState(() {
                        try {
                          ingredient.cost = double.parse(cost);
                        } catch (_) {}
                      });
                    },
                    style: Theme.of(context).textTheme.labelLarge)))
      ]),
      Row(children: [
        const Spacer(),
        Expanded(
            flex: 7,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(ingredient.displayCreatedText(context),
                          style: Theme.of(context).textTheme.labelSmall),
                      ingredient.categoryWidget(context,
                          style: Theme.of(context).textTheme.labelSmall)
                    ])))
      ]),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            TextButton(
                onPressed: () => onRemove(context, widget.ingredient),
                child: const Text("リセット")),
            TextButton(
                onPressed: () => useUp(context, widget.ingredient),
                child: const Text("使い切る")),
            TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: colorScheme.error,
                    foregroundColor: colorScheme.inversePrimary),
                onPressed: () => onDelete(context, widget.ingredient),
                child: const Text("削除"))
          ]))
    ]);
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
}
