import 'package:emeal_app/models/meal_prep.dart';
import 'package:emeal_app/services/authentication.dart';
import 'package:emeal_app/services/database.dart';
import 'package:emeal_app/services/firestore_crud_api.dart';
import 'package:emeal_app/views/home/components/meal-preps/meal_preps_list_view.dart';
import 'package:flutter/material.dart';

class MealPrepView extends StatefulWidget {
  final List<MealPrep> selected;

  const MealPrepView({super.key, required this.selected});

  @override
  State<StatefulWidget> createState() => MealPrepViewState();
}

class MealPrepViewState extends State<MealPrepView> {
  final _key = GlobalKey<MealPrepViewState>();
  @override
  Widget build(BuildContext context) {
    final api = Database().provider<MealPrep>(
        FirestoreCRUDApi(MealPrep.collection, MealPrep.fromJson));
    return FutureBuilder(
        future: api.list(
            query: (ref) => ref
                .orderBy("created", descending: true)
                .where("user", isEqualTo: Authentication().currentUser.uid)
                .where("is_used_up", isEqualTo: false)
                .limit(15)),
        builder: ((context, snapshot) {
          final data = snapshot.data;
          if (data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (data.isEmpty) {
            return const Center(child: Text("作り置きを投稿しましょう！"));
          }
          return MealPrepsListView(key: _key, mealPreps: data);
        }));
  }
}
