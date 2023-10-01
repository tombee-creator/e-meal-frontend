import 'package:emeal_app/models/meal/meal.dart';
import 'package:emeal_app/services/database.dart';
import 'package:emeal_app/services/emeal_crud_api.dart';
import 'package:emeal_app/views/home/components/meal/meal_info_view.dart';
import 'package:emeal_app/views/home/components/meal/meal_list_view.dart';
import 'package:flutter/material.dart';

class MealView extends StatefulWidget {
  final bool isFetch;
  const MealView({super.key, required this.isFetch});

  @override
  State<StatefulWidget> createState() => MealViewState();
}

class MealViewState extends State<MealView> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
          height: 72.0,
          child: FutureBuilder(
              future: fetchData(),
              builder: ((context, snapshot) =>
                  MealInfoView(data: snapshot.data)))),
      Expanded(
          child: FutureBuilder(
              future: fetchData(),
              builder: (context, snapshot) {
                final data = snapshot.data;
                if (data == null || !snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (data.isEmpty) {
                  return const Center(child: Text("食事を投稿しましょう！"));
                }
                return MealListView(meals: data);
              }))
    ]);
  }

  Future<List<Meal>> fetchData() async {
    return Database()
        .provider<Meal>(EMealCrudApi(Meal.collection, Meal.fromJson))
        .list();
  }
}
