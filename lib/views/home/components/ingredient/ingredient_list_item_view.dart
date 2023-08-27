import 'package:emeal_app/models/ingredient.dart';
import 'package:emeal_app/models/prep_ingredient_relationship.dart';
import 'package:emeal_app/services/database.dart';
import 'package:emeal_app/services/firestore_crud_api.dart';
import 'package:emeal_app/views/helper/image/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IngredientListItemView extends StatefulWidget {
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
  State<StatefulWidget> createState() => _IngredientListItemViewState();
}

class _IngredientListItemViewState extends State<IngredientListItemView> {
  int? usedCount;

  @override
  void didChangeDependencies() {
    getUsedCount().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {
        if (mounted) {
          usedCount = value;
        }
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final list = <Widget>[];
    list.add(AspectRatio(
      aspectRatio: 1.0,
      child: ImageHelper.image(widget.ingredient.url),
    ));
    list.add(Expanded(
        flex: 5,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.ingredient.name),
              Text(DateFormat("yyyy/MM/dd HH:mm", "ja_JP")
                  .format(widget.ingredient.created))
            ],
          ),
        )));
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

  void Function()? onTap() {
    if (usedCount == null) {
      return null;
    }
    return () {
      final usedCount = this.usedCount;
      if (usedCount == null) {
        return;
      }

      final countUsedUp = widget.count + usedCount;
      if (countUsedUp >= widget.ingredient.times) {
        widget.onRemove(widget.ingredient);
      } else {
        if (countUsedUp < widget.ingredient.times - 1) {
          widget.onSelected(widget.ingredient);
        } else {
          widget.onSelected(widget.ingredient.usedUp());
        }
      }
    };
  }

  Future<int> getUsedCount() async {
    final items = await Database()
        .provider(FirestoreCRUDApi(
            PrepIngredientRelation.collection, PrepIngredientRelation.fromJson))
        .list(
            query: (ref) =>
                ref.where("ingredient", isEqualTo: widget.ingredient.id));
    final contains = await Future.wait(items);
    if (items.isEmpty) {
      return 0;
    }
    return contains.map((contain) => contain.count).reduce((v1, v2) => v1 + v2);
  }
}
