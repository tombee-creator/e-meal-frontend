import 'package:emeal_app/models/ingredient/ingredient.dart';
import 'package:emeal_app/services/database.dart';
import 'package:emeal_app/services/emeal_crud_api.dart';
import 'package:emeal_app/views/home/components/ingredient/ingredient_list_view.dart';
import 'package:flutter/material.dart';

class IngredientView extends StatefulWidget {
  final List<Ingredient> selected;
  final void Function(Ingredient) onSelected;
  final void Function(Ingredient) onRemove;
  final bool isFetch;

  const IngredientView(
      {super.key,
      required this.selected,
      required this.onSelected,
      required this.onRemove,
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
    final availableData = data.where((prep) => !prep.isUsedUp).toList();
    if (availableData.isEmpty) {
      return const Center(child: Text("食材を投稿しましょう！"));
    }
    return IngredientListView(
        ingredients: availableData, selected: widget.selected);
  }

  void fetchData() {
    Database()
        .provider<Ingredient>(
            EMealCrudApi(Ingredient.collection, Ingredient.fromJson))
        .list()
        .then((value) {
      if (mounted) {
        setState(() {
          data = value;
        });
      }
    });
  }
}
