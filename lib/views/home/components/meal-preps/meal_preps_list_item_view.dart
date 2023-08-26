import 'package:emeal_app/models/meal_prep.dart';
import 'package:emeal_app/views/helper/image/image_helper.dart';
import 'package:emeal_app/views/home/components/meal-tab/meal_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MealPrepListItemView extends StatelessWidget {
  final MealPrep mealPrep;
  final int count;

  const MealPrepListItemView(
      {super.key, required this.mealPrep, required this.count});

  @override
  Widget build(BuildContext context) {
    final list = <Widget>[];
    list.add(AspectRatio(
      aspectRatio: 1.0,
      child: ImageHelper.image(mealPrep.url),
    ));
    list.add(Expanded(
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
    ));
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
          if (count >= mealPrep.times) {
            onRemove(context, mealPrep);
          } else {
            onSelected(context, mealPrep);
          }
        },
        child: Card(
            color: count > 0 ? Theme.of(context).colorScheme.background : null,
            child: Row(children: list)));
  }

  void onSelected(BuildContext context, MealPrep mealPrep) {
    final currentState = context.findAncestorStateOfType<MealTabBarViewState>();
    // ignore: invalid_use_of_protected_member
    currentState?.setState(() => currentState.mealPreps.add(mealPrep));
  }

  void onRemove(BuildContext context, MealPrep mealPrep) {
    final currentState = context.findAncestorStateOfType<MealTabBarViewState>();
    // ignore: invalid_use_of_protected_member
    currentState?.setState(() {
      currentState.mealPreps = currentState.mealPreps
          .where((item) => item.id != mealPrep.id)
          .toList();
    });
  }
}
