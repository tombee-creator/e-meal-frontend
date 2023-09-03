import 'package:emeal_app/models/meal_prep.dart';
import 'package:emeal_app/services/database.dart';
import 'package:emeal_app/services/emeal_crud_api.dart';
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

  List<MealPrep>? data;

  @override
  void didChangeDependencies() {
    Database()
        .provider<MealPrep>(
            EMealCrudApi(MealPrep.collection, MealPrep.fromJson))
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
    final availableData = data.where((prep) => !prep.isUsedUp).toList();
    if (availableData.isEmpty) {
      return const Center(child: Text("作り置きを投稿しましょう！"));
    }
    return MealPrepsListView(key: _key, mealPreps: availableData);
  }
}
