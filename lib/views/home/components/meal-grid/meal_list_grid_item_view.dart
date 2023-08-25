import 'package:emeal_app/views/pages/meal_page.dart';
import 'package:flutter/material.dart';
import 'package:emeal_app/models/meal.dart';
import 'package:emeal_app/views/helper/image/image_helper.dart';

class MealListGridItemView extends StatelessWidget {
  final Meal meal;

  const MealListGridItemView({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => MealPage(title: "e-Meal", id: meal.id)));
        },
        child:
            AspectRatio(aspectRatio: 1.0, child: ImageHelper.image(meal.url)));
  }
}
