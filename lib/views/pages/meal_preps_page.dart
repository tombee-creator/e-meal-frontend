import 'package:emeal_app/models/meal_prep.dart';
import 'package:emeal_app/views/home/components/meal-preps/meal_preps_detail_view.dart';
import 'package:emeal_app/views/home/components/meal-preps/meal_preps_post_view.dart';
import 'package:flutter/material.dart';
import 'package:emeal_app/services/database.dart';
import 'package:emeal_app/services/firestore_crud_api.dart';

class MealPrepsPage extends StatelessWidget {
  final String title;
  final String? id;

  const MealPrepsPage({super.key, required this.title, this.id});

  @override
  Widget build(BuildContext context) {
    final id = this.id;
    final api = Database().provider(
        FirestoreCRUDApi<MealPrep>(MealPrep.collection, MealPrep.fromJson));
    if (id == null) {
      return Scaffold(
          appBar: AppBar(
            title: const Text("投稿"),
          ),
          body: const SafeArea(
            child: MealPrepPostView(),
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
                    return const Center(
                      child: Text("ロード中"),
                    );
                  }
                  return MealPrepDetailView(mealPrep: ingredient);
                }))));
  }
}
