import 'package:emeal_app/services/emeal_crud_api.dart';
import 'package:emeal_app/views/home/components/meal/meal_post_view.dart';
import 'package:flutter/material.dart';
import 'package:emeal_app/models/meal.dart';
import 'package:emeal_app/services/database.dart';
import 'package:emeal_app/views/home/components/meal/meal_detail_view.dart';

class MealPage extends StatelessWidget {
  final String title;
  final String? id;

  const MealPage({super.key, required this.title, this.id});

  @override
  Widget build(BuildContext context) {
    final id = this.id;
    final api =
        Database().provider(EMealCrudApi<Meal>(Meal.collection, Meal.fromJson));
    if (id == null) {
      return Scaffold(
          appBar: AppBar(
            title: const Text("投稿"),
          ),
          body: const SafeArea(
            child: MealPostView(),
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
                    return const Center(
                      child: Text("ロード中"),
                    );
                  }
                  return RecipeDetailView(recipe: recipe);
                }))));
  }
}
