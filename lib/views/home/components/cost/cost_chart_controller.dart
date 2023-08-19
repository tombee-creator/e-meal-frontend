import 'package:flutter/material.dart';
import 'package:tsumitabe_app/models/recipe.dart';
import 'package:tsumitabe_app/services/database.dart';
import 'package:tsumitabe_app/services/firestore_crud_api.dart';
import 'package:tsumitabe_app/views/home/components/cost/cost_chart_view.dart';

class CostChartControllerView extends StatefulWidget {
  const CostChartControllerView({super.key});

  @override
  State<StatefulWidget> createState() => _CostChartControllerViewState();
}

class _CostChartControllerViewState extends State<CostChartControllerView> {
  DateTime focusDate = DateTime.now();

  @override
  void initState() {
    focusDate = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final api = Database()
        .provider(FirestoreCRUDApi<Recipe>("recipes", Recipe.fromJson));
    final startDate =
        DateTime(focusDate.year, focusDate.month, focusDate.day - 7);
    return Row(
      children: [
        SizedBox(
          width: 32,
          child: IconButton(
            onPressed: () {
              setState(() {
                focusDate = focusDate.add(const Duration(days: -1));
              });
            },
            icon: const Icon(Icons.arrow_back),
            iconSize: 20,
          ),
        ),
        Expanded(
            child: FutureBuilder(
          future: api.list(
              query: (ref) => ref
                  .where("create",
                      isGreaterThan: startDate.toIso8601String(),
                      isLessThanOrEqualTo: focusDate.toIso8601String())
                  .orderBy("create")),
          builder: (context, snapshot) {
            final recipes = snapshot.data;
            if (recipes == null) {
              return const Center(child: CircularProgressIndicator());
            }
            if (recipes.isEmpty) {
              return const Center(child: Text("ただいまデータはありません"));
            }
            return CostChartView(
              recipes: recipes,
              focus: focusDate,
            );
          },
        )),
        SizedBox(
          width: 32,
          child: IconButton(
            onPressed: () {
              setState(() {
                focusDate = focusDate.add(const Duration(days: 1));
              });
            },
            icon: const Icon(Icons.arrow_forward),
            iconSize: 20,
          ),
        ),
      ],
    );
  }
}
