import 'package:emeal_app/models/recipe.dart';
import 'package:emeal_app/views/helper/image/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LunchListItemView extends StatelessWidget {
  final Recipe recipe;

  const LunchListItemView({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
      children: [
        AspectRatio(
          aspectRatio: 1.0,
          child: ImageHelper.image(recipe.url),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(recipe.comment),
              Text(DateFormat("yyyy/MM/dd HH:mm", "ja_JP")
                  .format(recipe.created))
            ],
          ),
        ),
      ],
    ));
  }
}
