import 'package:emeal_app/views/helper/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:emeal_app/models/meal_prep.dart';
import 'package:emeal_app/services/database.dart';
import 'package:emeal_app/models/meal_prep_contains.dart';
import 'package:emeal_app/services/firestore_crud_api.dart';
import 'package:emeal_app/views/home/components/meal-tab/meal_tab_bar_view.dart';

class MealPrepListItemView extends StatefulWidget {
  final MealPrep mealPrep;
  final int count;

  const MealPrepListItemView(
      {super.key, required this.mealPrep, required this.count});

  @override
  State<StatefulWidget> createState() => _MealPrepListItemViewState();
}

class _MealPrepListItemViewState extends State<MealPrepListItemView> {
  int? usedCount;

  @override
  void didChangeDependencies() {
    getUsedCount().then((value) {
      if (mounted) {
        setState(() => usedCount = value);
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final list = <Widget>[];
    list.add(const AspectRatio(
      aspectRatio: 1.0,
      child: Icon(Icons.food_bank),
    ));
    list.add(Expanded(
      flex: 5,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.mealPrep.name),
            Text(DateFormatter().format(widget.mealPrep.created))
          ],
        ),
      ),
    ));
    if (widget.count > 0) {
      list.add(Padding(
        padding: const EdgeInsets.all(12.0),
        child: CircleAvatar(
          radius: 18.0,
          child: Text(
            "${widget.count}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ));
    }
    return GestureDetector(
        onTap: onTap(),
        child: Card(
            color: widget.count > 0
                ? Theme.of(context).colorScheme.background
                : null,
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

  void Function()? onTap() {
    if (usedCount == null) {
      return null;
    }
    return () {
      final usedCount = this.usedCount;
      if (usedCount == null) {
        return;
      }
      final usedUpCount = widget.count + usedCount;
      if (usedUpCount >= widget.mealPrep.times) {
        onRemove(context, widget.mealPrep);
      } else {
        if (usedUpCount < widget.mealPrep.times - 1) {
          onSelected(context, widget.mealPrep);
        } else {
          onSelected(context, widget.mealPrep.usedUp());
        }
      }
    };
  }

  Future<int> getUsedCount() async {
    final items = await Database()
        .provider(FirestoreCRUDApi(
            MealPrepContains.collection, MealPrepContains.fromJson))
        .list(
            query: (ref) =>
                ref.where("meal_prep", isEqualTo: widget.mealPrep.id));
    final contains = await Future.wait(items);
    if (contains.isEmpty) {
      return 0;
    }
    return contains.map((contain) => contain.count).reduce((v1, v2) => v1 + v2);
  }
}
