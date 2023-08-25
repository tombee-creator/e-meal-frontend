import 'package:emeal_app/models/ingredient.dart';
import 'package:emeal_app/views/helper/image/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IngredientListItemView extends StatelessWidget {
  final Ingredient ingredient;

  const IngredientListItemView({super.key, required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
      children: [
        AspectRatio(
          aspectRatio: 1.0,
          child: ImageHelper.image(ingredient.url),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(ingredient.name),
              Text(DateFormat("yyyy/MM/dd HH:mm", "ja_JP")
                  .format(ingredient.created))
            ],
          ),
        ),
      ],
    ));
  }
}
