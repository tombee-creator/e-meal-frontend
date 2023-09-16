import 'package:emeal_app/models/converters/category_converter.dart';
import 'package:emeal_app/models/ingredient/ingredient.dart';
import 'package:emeal_app/services/database.dart';
import 'package:emeal_app/services/emeal_crud_api.dart';
import 'package:emeal_app/views/home/components/ingredient/ingredient_list_view.dart';
import 'package:flutter/material.dart';

class IngredientView extends StatefulWidget {
  final List<Category> categories;
  final List<Ingredient> selected;
  final bool isFetch;

  const IngredientView(
      {super.key,
      required this.categories,
      required this.selected,
      required this.isFetch});

  @override
  State<StatefulWidget> createState() => IngredientViewState();
}

class IngredientViewState extends State<IngredientView> {
  List<Ingredient>? data;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchData();
  }

  @override
  void didUpdateWidget(covariant IngredientView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFetch) {
      fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = this.data;
    if (data == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (data.isEmpty) {
      return const Center(child: Text("食材を投稿しましょう！"));
    }
    return IngredientListView(ingredients: data, selected: widget.selected);
  }

  void fetchData() {
    var query = widget.categories
        .map((category) {
          final name = const CategoryConverter().indexOf(category);
          return "category=$name";
        })
        .toList()
        .join("&");
    query += "&is_used_up=false";
    Database()
        .provider<Ingredient>(
            EMealCrudApi(Ingredient.collection, Ingredient.fromJson))
        .list(query: query)
        .then((value) {
      if (mounted) {
        setState(() {
          data = value;
        });
      }
    });
  }
}
