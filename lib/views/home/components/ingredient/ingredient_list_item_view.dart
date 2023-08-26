import 'package:emeal_app/models/ingredient.dart';
import 'package:emeal_app/views/helper/image/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IngredientListItemView extends StatelessWidget {
  final Ingredient ingredient;
  final int count;
  final void Function(Ingredient) onSelected;
  final void Function(Ingredient) onRemove;

  const IngredientListItemView(
      {super.key,
      required this.ingredient,
      required this.count,
      required this.onSelected,
      required this.onRemove});

  @override
  Widget build(BuildContext context) {
    final list = <Widget>[];
    list.add(AspectRatio(
      aspectRatio: 1.0,
      child: ImageHelper.image(ingredient.url),
    ));
    list.add(Expanded(
        flex: 5,
        child: Padding(
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
        )));
    if (count > 0) {
      list.add(Padding(
        padding: const EdgeInsets.all(12.0),
        child: CircleAvatar(
          radius: 18.0,
          child: Text(
            "$count",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ));
    }
    return GestureDetector(
        onTap: () {
          if (count >= ingredient.times) {
            onRemove(ingredient);
          } else {
            onSelected(ingredient);
          }
        },
        child: Card(
            color: count > 0 ? Theme.of(context).colorScheme.background : null,
            child: Row(children: list)));
  }
}
