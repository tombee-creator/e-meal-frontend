import 'package:emeal_app/models/ingredient.dart';
import 'package:emeal_app/views/home/components/ingredient/ingredient_detail_view.dart';
import 'package:emeal_app/views/home/components/ingredient/ingredient_post_view.dart';
import 'package:flutter/material.dart';
import 'package:emeal_app/services/database.dart';
import 'package:emeal_app/services/firestore_crud_api.dart';
import 'package:emeal_app/views/home/components/recipe/recipe_loading_view.dart';

class IngredientPage extends StatelessWidget {
  final String title;
  final String? id;

  const IngredientPage({super.key, required this.title, this.id});

  @override
  Widget build(BuildContext context) {
    final id = this.id;
    final api = Database().provider(FirestoreCRUDApi<Ingredient>(
        Ingredient.collection, Ingredient.fromJson));
    if (id == null) {
      return Scaffold(
          appBar: AppBar(
            title: const Text("投稿"),
          ),
          body: const SafeArea(
            child: IngredientPostView(),
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
                  final ingredient = snapshot.data;
                  if (ingredient == null) {
                    return const RecipeLoadingView();
                  }
                  return IngredientDetailView(ingredient: ingredient);
                }))));
  }
}
