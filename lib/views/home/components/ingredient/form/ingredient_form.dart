import 'package:emeal_app/generated/l10n.dart';
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
                        ingredient.cost = double.parse(cost);
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
      ])
    ]);
  }
}
