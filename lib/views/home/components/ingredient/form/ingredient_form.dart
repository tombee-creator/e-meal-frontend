import 'package:emeal_app/models/ingredient/ingredient.dart';
import 'package:flutter/material.dart';

class IngredientForm extends StatelessWidget {
  final bool isChecked;
  final Ingredient ingredient;
  final void Function(Ingredient) onCheckboxChanged;

  const IngredientForm(
      {super.key,
      required this.isChecked,
      required this.ingredient,
      required this.onCheckboxChanged});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Checkbox(
          value: isChecked,
          onChanged: (isChecked) {
            onCheckboxChanged(ingredient);
          }),
      Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(ingredient.name, style: Theme.of(context).textTheme.labelLarge),
        Text(ingredient.displayCreatedText(context),
            style: Theme.of(context).textTheme.labelSmall)
      ])),
      Expanded(
          child: Text(ingredient.displayCostText(context),
              style: Theme.of(context).textTheme.labelLarge))
    ]);
  }
}
