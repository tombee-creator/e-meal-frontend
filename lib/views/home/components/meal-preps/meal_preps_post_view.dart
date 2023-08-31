import 'dart:io';
import 'package:emeal_app/models/ingredient.dart';
import 'package:emeal_app/views/home/components/meal-preps/meal_preps_post_button.dart';
import 'package:flutter/material.dart';
import 'package:emeal_app/helper/image_picker_provider.dart';
import 'package:emeal_app/views/home/components/meal/meal_field_form.dart';

class MealPrepPostView extends StatefulWidget {
  const MealPrepPostView({super.key});

  @override
  State<StatefulWidget> createState() => _MealPrepPostViewState();
}

class _MealPrepPostViewState extends State<MealPrepPostView> {
  List<Ingredient> selected = <Ingredient>[];
  double cost = 0.0;
  int times = 1;
  String name = "";
  File? image;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments as Map;
    selected = args['ingredients'] ?? [];

    if (selected.isNotEmpty) {
      cost = selected
          .map((item) => item.cost / item.times)
          .reduce((cost1, cost2) => cost1 + cost2);
    }
    super.didChangeDependencies();
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
            MealPrepPostButton(
                name: name, cost: cost, times: times, ingredients: selected)
          ],
        ))
      ],
    );
  }

  Future getImage() async {
    final provider = ImagePickerProvider();
    provider.getImage((image) {
      setState(() {
        this.image = image;
      });
    });
  }
}
