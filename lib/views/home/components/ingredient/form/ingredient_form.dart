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
      Expanded(child: Text(ingredient.name)),
      Expanded(child: Text(ingredient.displayCostText(context)))
    ]);
  }
}
