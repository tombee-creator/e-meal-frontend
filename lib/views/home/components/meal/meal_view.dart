import 'package:emeal_app/models/meal.dart';
import 'package:emeal_app/services/database.dart';
import 'package:emeal_app/services/emeal_crud_api.dart';
import 'package:emeal_app/views/home/components/meal/meal_list_view.dart';
import 'package:flutter/material.dart';

class MealView extends StatefulWidget {
  final bool isFetch;
  const MealView({super.key, required this.isFetch});

  @override
  State<StatefulWidget> createState() => MealViewState();
}

class MealViewState extends State<MealView> {
  List<Meal>? data;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchData();
  }

  @override
  void didUpdateWidget(covariant MealView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFetch) {
      fetchData();
    }
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

  void fetchData() {
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
  }
}
