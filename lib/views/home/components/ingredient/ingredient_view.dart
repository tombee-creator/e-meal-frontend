import 'package:emeal_app/models/ingredient.dart';
import 'package:emeal_app/services/database.dart';
import 'package:emeal_app/services/emeal_crud_api.dart';
import 'package:emeal_app/views/home/components/ingredient/ingredient_list_view.dart';
import 'package:flutter/material.dart';

class IngredientView extends StatefulWidget {
  final List<Ingredient> selected;
  final void Function(Ingredient) onSelected;
  final void Function(Ingredient) onRemove;

  const IngredientView(
      {super.key,
      required this.selected,
      required this.onSelected,
      required this.onRemove});

  @override
  State<StatefulWidget> createState() => IngredientViewState();
}

class IngredientViewState extends State<IngredientView> {
  List<Ingredient>? data;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    updateData();
  }

  @override
  void didUpdateWidget(covariant IngredientView oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateData();
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
      ingredients: availableData,
      selected: widget.selected,
      onSelected: widget.onSelected,
      onRemove: widget.onRemove,
    );
  }

  void updateData() {
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
