import 'package:flutter/material.dart';
import 'package:tsumitabe_app/models/recipe.dart';
import 'package:tsumitabe_app/services/database.dart';
import 'package:tsumitabe_app/services/firestore_crud_api.dart';
import 'package:tsumitabe_app/views/home/components/recipe/recipe_list_view.dart';

class HomeComponent extends StatefulWidget {
  const HomeComponent({super.key});

  @override
  State<StatefulWidget> createState() => _HomeComponentState();
}

class _HomeComponentState extends State<HomeComponent> {
  @override
  Widget build(BuildContext context) {
    final api = Database()
        .provider(FirestoreCRUDApi<Recipe>("recipes", Recipe.fromJson));

    return RecipeListView(future: api.list());
  }
}
