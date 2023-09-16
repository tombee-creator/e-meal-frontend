import 'package:emeal_app/models/ingredient/ingredient.dart';
import 'package:flutter/material.dart';
import 'package:emeal_app/views/home/components/ingredient/ingredient_post_button.dart';
import 'package:emeal_app/views/home/components/meal/meal_field_form.dart';

class IngredientPostView extends StatefulWidget {
  const IngredientPostView({super.key});

  @override
  State<StatefulWidget> createState() => _IngredientPostViewState();
}

class _IngredientPostViewState extends State<IngredientPostView> {
  double cost = 0.0;
  int times = 1;
  String name = "";

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments as Map;
    final selected = (args['ingredients'] ?? []) as List<Ingredient>;
    super.didChangeDependencies();

    if (selected.isNotEmpty) {
      cost = selected
          .map((e) => e.cost / e.times)
          .reduce((cost1, cost2) => cost1 + cost2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Column(
          children: [
            MealFieldForm(
              hintText: "名前",
              icon: Icons.description,
              onChange: (name) {
                setState(() {
                  this.name = name;
                });
              },
            ),
            MealFieldForm(
              hintText: cost == 0.0 ? "コスト" : "$cost",
              icon: Icons.currency_yen,
              onChange: (cost) {
                final parsedCost = double.tryParse(cost) ?? 0.0;
                setState(() {
                  this.cost = parsedCost;
                });
              },
            ),
            MealFieldForm(
              hintText: "使用回数",
              icon: Icons.countertops,
              onChange: (times) {
                final parsedTimes = int.tryParse(times) ?? 1;
                setState(() {
                  this.times = parsedTimes;
                });
              },
            ),
            const Spacer(),
            IngredientPostButton(name: name, cost: cost, times: times)
          ],
        ))
      ],
    );
  }
}
