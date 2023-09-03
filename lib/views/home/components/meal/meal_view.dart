import 'package:emeal_app/models/meal.dart';
import 'package:emeal_app/services/database.dart';
import 'package:emeal_app/services/emeal_crud_api.dart';
import 'package:emeal_app/views/home/components/meal/meal_list_view.dart';
import 'package:flutter/material.dart';

class MealView extends StatefulWidget {
  const MealView({super.key});

  @override
  State<StatefulWidget> createState() => MealViewState();
}

class MealViewState extends State<MealView> {
  List<Meal>? data;

  @override
  void didChangeDependencies() {
    Database()
        .provider<Meal>(EMealCrudApi(Meal.collection, Meal.fromJson))
        .list()
        .then((value) {
      if (mounted) {
        setState(() {
          data = value;
        });
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final data = this.data;
    if (data == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (data.isEmpty) {
      return const Center(child: Text("食事を投稿しましょう！"));
    }
    return MealListView(meals: data);
  }
}
