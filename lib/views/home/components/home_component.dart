import 'package:flutter/material.dart';
import 'package:emeal_app/models/meal.dart';
import 'package:emeal_app/services/database.dart';
import 'package:emeal_app/services/firestore_crud_api.dart';
import 'package:emeal_app/views/home/components/recipe/recipe_list_view.dart';

class HomeComponent extends StatefulWidget {
  const HomeComponent({super.key});

  @override
  State<StatefulWidget> createState() => _HomeComponentState();
}

class _HomeComponentState extends State<HomeComponent> {
  @override
  Widget build(BuildContext context) {
    final api =
        Database().provider(FirestoreCRUDApi<Meal>("recipes", Meal.fromJson));

    return RecipeListView(
        future: api.list(
            query: (ref) =>
                ref.orderBy("created", descending: true).limit(15)));
  }
}
