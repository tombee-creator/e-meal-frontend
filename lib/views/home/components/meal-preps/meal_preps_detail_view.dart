import 'package:emeal_app/models/meal_prep.dart';
import 'package:flutter/material.dart';
import 'package:emeal_app/views/helper/image/image_helper.dart';

class MealPrepDetailView extends StatelessWidget {
  final MealPrep mealPrep;

  const MealPrepDetailView({super.key, required this.mealPrep});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ImageHelper.image(mealPrep.url),
      ],
    );
  }
}
