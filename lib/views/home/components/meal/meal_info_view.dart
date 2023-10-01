import 'package:emeal_app/models/meal/meal.dart';
import 'package:flutter/material.dart';

class MealInfoView extends StatelessWidget {
  final List<Meal>? data;
  const MealInfoView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Text("レシピ数"), Text(getText())]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Text("平均"), Text(getText())])
        ]));
  }

  String getText() {
    final data = this.data;
    if (data == null) {
      return "--";
    }
    return data.length.toString();
  }
}
