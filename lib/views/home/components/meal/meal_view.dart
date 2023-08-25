import 'package:emeal_app/models/meal.dart';
import 'package:emeal_app/services/authentication.dart';
import 'package:emeal_app/services/database.dart';
import 'package:emeal_app/services/firestore_crud_api.dart';
import 'package:emeal_app/views/home/components/meal/meal_list_view.dart';
import 'package:flutter/material.dart';

class MealView extends StatefulWidget {
  const MealView({super.key});

  @override
  State<StatefulWidget> createState() => MealViewState();
}

class MealViewState extends State<MealView> {
  @override
  Widget build(BuildContext context) {
    final api = Database()
        .provider<Meal>(FirestoreCRUDApi(Meal.collection, Meal.fromJson));
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
          return MealListView(meals: data);
        }));
  }
}
