import 'package:emeal_app/views/home/components/lunch/lunch_post_view.dart';
import 'package:flutter/material.dart';
import 'package:emeal_app/models/recipe.dart';
import 'package:emeal_app/services/database.dart';
import 'package:emeal_app/services/firestore_crud_api.dart';
import 'package:emeal_app/views/home/components/recipe/recipe_detail_view.dart';
import 'package:emeal_app/views/home/components/recipe/recipe_loading_view.dart';

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
            title: const Text("投稿"),
          ),
          body: const SafeArea(
            child: LunchPostView(),
          ));
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
