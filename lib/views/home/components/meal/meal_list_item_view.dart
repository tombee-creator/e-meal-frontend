import 'package:emeal_app/models/meal/meal.dart';
import 'package:emeal_app/views/helper/image/image_helper.dart';
import 'package:flutter/material.dart';

class MealListItemView extends StatelessWidget {
  final Meal recipe;

  const MealListItemView({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[];
    items.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                const Padding(
                    padding: EdgeInsets.all(8.0), child: Icon(Icons.inventory)),
                Text(recipe.comment)
              ]),
              const Spacer(),
              Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(recipe.costText(context),
                            style: const TextStyle(fontSize: 12.0)),
                        Text(recipe.createdText(context),
                            style: const TextStyle(fontSize: 12.0))
                      ]))
            ])));
    items.add(const Spacer());
    items.add(AspectRatio(aspectRatio: 1.0, child: image()));
    return Card(
        child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 120),
            child: Row(children: items)));
  }

  Widget image() {
    final url = Uri.parse(recipe.url);
    if (url.hasScheme) {
      return ImageHelper.image(recipe.url);
    }
    return const AspectRatio(
      aspectRatio: 1.0,
      child: Icon(Icons.inventory, color: Colors.black),
    );
  }
}
