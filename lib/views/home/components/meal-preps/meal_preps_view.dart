import 'package:emeal_app/models/meal_prep.dart';
import 'package:emeal_app/services/authentication.dart';
import 'package:emeal_app/services/database.dart';
import 'package:emeal_app/services/firestore_crud_api.dart';
import 'package:emeal_app/views/home/components/meal-preps/meal_preps_list_view.dart';
import 'package:flutter/material.dart';

class MealPrepView extends StatefulWidget {
  const MealPrepView({super.key});

  @override
  State<StatefulWidget> createState() => _MealPrepViewState();
}

class _MealPrepViewState extends State<MealPrepView> {
  @override
  Widget build(BuildContext context) {
    final api = Database().provider<MealPrep>(
        FirestoreCRUDApi(MealPrep.collection, MealPrep.fromJson));
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
          return MealPrepsListView(mealPreps: data);
        }));
  }
}
