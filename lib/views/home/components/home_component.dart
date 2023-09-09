import 'package:emeal_app/services/emeal_crud_api.dart';
import 'package:emeal_app/views/helper/ad/ad_mob.dart';
import 'package:emeal_app/views/home/components/meal-grid/meal_list_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:emeal_app/models/meal.dart';
import 'package:emeal_app/services/database.dart';

class HomeComponent extends StatefulWidget {
  const HomeComponent({super.key});

  @override
  State<StatefulWidget> createState() => _HomeComponentState();
}

class _HomeComponentState extends State<HomeComponent> {
  @override
  Widget build(BuildContext context) {
    final api =
        Database().provider(EMealCrudApi<Meal>(Meal.collection, Meal.fromJson));

    return Column(
      children: [
        const AdMob(),
        Expanded(
            child: MealListGridView(
                future: api.list(
                    query: (ref) =>
                        ref.orderBy("created", descending: true).limit(15))))
      ],
    );
  }
}
