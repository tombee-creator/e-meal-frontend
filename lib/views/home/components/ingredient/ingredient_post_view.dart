import 'package:emeal_app/generated/l10n.dart';
import 'package:emeal_app/models/ingredient/ingredient.dart';
import 'package:emeal_app/models/ingredient/used_ingredient_info.dart';
import 'package:emeal_app/views/home/components/ingredient/ingredient_list_view.dart';
import 'package:flutter/material.dart';
import 'package:emeal_app/views/home/components/ingredient/ingredient_post_button.dart';
import 'package:emeal_app/views/common/meal_text_field_form.dart';

class IngredientPostView extends StatefulWidget {
  const IngredientPostView({super.key});

  @override
  State<StatefulWidget> createState() => _IngredientPostViewState();
}

class _IngredientPostViewState extends State<IngredientPostView> {
  double cost = 0.0;
  int times = 1;
  String name = "";

  late Category category;
  late List<UsedIngredientPostInfo> selected;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments as Map;
    selected = (args['ingredients'] ?? []) as List<UsedIngredientPostInfo>;
    super.didChangeDependencies();

    if (selected.isNotEmpty) {
      category = Category.prep;
      cost = selected
          .map((e) => e.ingredient.cost)
          .reduce((cost1, cost2) => cost1 + cost2);
    } else {
      category = Category.ingredient;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MealTextFieldForm(
          hintText: "名前",
          icon: Icons.description,
          onChange: (name) {
            setState(() {
              this.name = name;
            });
          },
        ),
        MealTextFieldForm(
          hintText: cost == 0.0 ? "コスト" : "$cost",
          icon: Icons.currency_yen,
          onChange: (cost) {
            final parsedCost = double.tryParse(cost) ?? 0.0;
            setState(() {
              this.cost = parsedCost;
            });
          },
        ),
        categoryChips(),
        Expanded(
            child: IngredientListView(
                ingredients: selected.map((item) => item.ingredient).toList(),
                selected: selected)),
        IngredientPostButton(
            name: name, cost: cost, times: times, category: category)
      ],
    );
  }

  Widget categoryChips() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      ChoiceChip(
          label: Text(S.of(context).category_label_INGREDIENT),
          onSelected: selectedAction(Category.ingredient),
          selected: category == Category.ingredient),
      ChoiceChip(
          label: Text(S.of(context).category_label_GIFT),
          onSelected: selectedAction(Category.gift),
          selected: category == Category.gift),
      ChoiceChip(
          label: Text(S.of(context).category_label_MEAL_PREP),
          onSelected: selectedAction(Category.prep),
          selected: category == Category.prep)
    ]);
  }

  Function(bool) selectedAction(Category category) {
    return (isSelected) {
      setState(() => this.category = category);
    };
  }
}
