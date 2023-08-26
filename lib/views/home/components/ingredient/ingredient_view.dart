import 'package:emeal_app/models/ingredient.dart';
import 'package:emeal_app/services/authentication.dart';
import 'package:emeal_app/services/database.dart';
import 'package:emeal_app/services/firestore_crud_api.dart';
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
  @override
  Widget build(BuildContext context) {
    final api = Database().provider<Ingredient>(
        FirestoreCRUDApi(Ingredient.collection, Ingredient.fromJson));
    return FutureBuilder(
        future: api.list(
            query: (ref) => ref
                .orderBy("created", descending: true)
                .where("user", isEqualTo: Authentication().currentUser.uid)
                .limit(15)),
        builder: ((context, snapshot) {
          final data = snapshot.data;
          if (data == null) {
            return const Center(
              child: Text("データを取得中です"),
            );
          }
          return IngredientListView(
            ingredients: data,
            selected: widget.selected,
            onSelected: widget.onSelected,
            onRemove: widget.onRemove,
          );
        }));
  }
}
