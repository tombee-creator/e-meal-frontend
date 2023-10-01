import 'package:emeal_app/generated/l10n.dart';
import 'package:emeal_app/models/converters/category_converter.dart';
import 'package:emeal_app/models/ingredient/ingredient.dart';
import 'package:emeal_app/models/ingredient/used_ingredient_info.dart';
import 'package:emeal_app/services/database.dart';
import 'package:emeal_app/services/emeal_crud_api.dart';
import 'package:emeal_app/views/home/components/ingredient/ingredient_list_view.dart';
import 'package:flutter/material.dart';

class IngredientView extends StatefulWidget {
  final List<UsedIngredientPostInfo> selected;
  final bool isFetch;

  const IngredientView(
      {super.key, required this.selected, required this.isFetch});

  @override
  State<StatefulWidget> createState() => IngredientViewState();
}

class IngredientViewState extends State<IngredientView> {
  List<Category> categories = Category.values.map((e) => e).toList();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(padding: const EdgeInsets.all(12.0), child: categoryChips()),
      Expanded(
          child: FutureBuilder(
              future: fetchData(),
              builder: (context, snapshot) {
                final data = snapshot.data;
                if (!snapshot.hasData || data == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (data.isEmpty) {
                  return Center(
                      child: Text(S.of(context).add_ingredient_label_text));
                }
                return IngredientListView(
                    ingredients: data, selected: widget.selected);
              }))
    ]);
  }

  Widget categoryChips() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(S.of(context).category_label),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ChoiceChip(
                label: Text(S.of(context).category_label_INGREDIENT),
                onSelected: selectedAction(Category.ingredient),
                selected: categories.contains(Category.ingredient))),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ChoiceChip(
                label: Text(S.of(context).category_label_GIFT),
                onSelected: selectedAction(Category.gift),
                selected: categories.contains(Category.gift))),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ChoiceChip(
                label: Text(S.of(context).category_label_MEAL_PREP),
                onSelected: selectedAction(Category.prep),
                selected: categories.contains(Category.prep)))
      ])
    ]);
  }

  Function(bool) selectedAction(Category category) {
    return (isSelected) {
      if (isSelected) {
        setState(() => categories.add(category));
      } else if (categories.length > 1) {
        setState(() => categories.remove(category));
      }
    };
  }

  Future<List<Ingredient>> fetchData() async {
    var query = categories
        .map((category) {
          final index = const CategoryConverter().indexOf(category);
          return "category=$index";
        })
        .toList()
        .join("&");
    query += "&is_used_up=false";
    return Database()
        .provider<Ingredient>(
            EMealCrudApi(Ingredient.collection, Ingredient.fromJson))
        .list(query: query);
  }
}
