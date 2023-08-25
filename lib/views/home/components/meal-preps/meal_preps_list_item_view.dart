import 'package:emeal_app/models/meal_prep.dart';
import 'package:emeal_app/views/helper/image/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MealPrepListItemView extends StatelessWidget {
  final MealPrep mealPrep;
  final int count;
  final void Function(MealPrep) onSelected;

  const MealPrepListItemView(
      {super.key,
      required this.mealPrep,
      required this.count,
      required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final list = <Widget>[];
    list.add(Card(
        child: Row(children: [
      AspectRatio(
        aspectRatio: 1.0,
        child: ImageHelper.image(mealPrep.url),
      ),
      Expanded(
        flex: 5,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(mealPrep.name),
              Text(DateFormat("yyyy/MM/dd HH:mm", "ja_JP")
                  .format(mealPrep.created))
            ],
          ),
        ),
      )
    ])));
    if (count > 0) {
      list.add(Align(
        alignment: Alignment.topRight,
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
          onSelected(mealPrep);
        },
        child: Stack(
          children: list,
        ));
  }
}
