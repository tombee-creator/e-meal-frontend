import 'package:emeal_app/models/ingredient/ingredient.dart';
import 'package:emeal_app/views/home/components/ingredient/ingredient_detail_view.dart';
import 'package:emeal_app/views/home/components/ingredient/ingredient_list_post_view.dart';
import 'package:emeal_app/views/home/components/ingredient/ingredient_post_view.dart';
import 'package:flutter/material.dart';
import 'package:emeal_app/services/database.dart';
import 'package:emeal_app/services/firestore_crud_api.dart';

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
      return DefaultTabController(
          length: 2,
          child: Scaffold(
              appBar: AppBar(
                  title: const Text("投稿"),
                  bottom: const TabBar(tabs: [
                    Tab(child: Icon(Icons.post_add)),
                    Tab(child: Icon(Icons.camera_alt))
                  ])),
              body: const SafeArea(
                  child: TabBarView(children: [
                IngredientPostView(),
                IngredientListPostView()
              ]))));
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
                    return const Center(
                      child: Text("ロード中"),
                    );
                  }
                  return IngredientDetailView(ingredient: ingredient);
                }))));
  }
}
