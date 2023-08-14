import 'package:flutter/material.dart';
import 'package:frontend/models/recipe.dart';
import 'package:frontend/services/database.dart';
import 'package:frontend/services/firestore_crud_api.dart';
import 'package:frontend/views/home/components/recipe/recipe_detail_view.dart';
import 'package:frontend/views/home/components/recipe/recipe_list_view.dart';
import 'package:frontend/views/home/components/recipe/recipe_loading_view.dart';

class RecipePage extends StatelessWidget {
  final String title;
  final String? id;

  const RecipePage({super.key, required this.title, this.id});

  @override
  Widget build(BuildContext context) {
    final id = this.id;
    final api = Database()
        .provider(FirestoreCRUDApi<Recipe>("recipes", Recipe.fromJson));
    if (id == null) {
      return Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: RecipeListView(future: api.list()));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: SafeArea(
            child: FutureBuilder(
                future: api.get(id),
                builder: ((context, snapshot) {
                  final recipe = snapshot.data;
                  if (recipe == null) {
                    return const RecipeLoadingView();
                  }
                  return RecipeDetailView(recipe: recipe);
                }))));
  }
}
