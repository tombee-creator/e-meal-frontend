import 'package:emeal_app/models/ingredient/ingredient.dart';
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
    return Row(children: [
      Checkbox(
          value: widget.isChecked,
          onChanged: (isChecked) {
            widget.onCheckboxChanged(ingredient);
          }),
      Expanded(
          flex: 2,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextFormField(
                initialValue: ingredient.name,
                onChanged: (name) {
                  setState(() {
                    ingredient.name = name;
                  });
                },
                style: Theme.of(context).textTheme.labelLarge),
            Text(ingredient.displayCreatedText(context),
                style: Theme.of(context).textTheme.labelSmall)
          ])),
      Expanded(
          flex: 1,
          child: TextFormField(
              initialValue: ingredient.cost.toString(),
              onChanged: (cost) {
                setState(() {
                  ingredient.cost = double.parse(cost);
                });
              },
              style: Theme.of(context).textTheme.labelLarge)),
      Expanded(
          flex: 1,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ingredient.categoryWidget(context,
                  style: Theme.of(context).textTheme.labelSmall)))
    ]);
  }
}
