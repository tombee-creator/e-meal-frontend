import 'package:flutter/material.dart';
import 'package:tsumitabe_app/models/recipe.dart';
import 'package:tsumitabe_app/views/home/components/cost/cost_chart_controller.dart';
import 'package:tsumitabe_app/views/home/components/cost/cost_description_item.dart.dart';

class FoodCostDescriptionView extends StatelessWidget {
  final Future<List<Recipe>> future;

  const FoodCostDescriptionView({super.key, required this.future});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: ((context, snapshot) {
          final data = snapshot.data ?? [];
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CostDescriptionItem.generate(
                      data: data,
                      icon: Icons.calendar_month,
                      label: "今月の食費",
                      value: (data) => data
                          .map((item) => item.cost)
                          .reduce((v1, v2) => v1 + v2),
                    ),
                    CostDescriptionItem.generate(
                      data: data,
                      icon: Icons.attach_money,
                      label: "毎食費の平均",
                      value: (data) =>
                          data
                              .map((item) => item.cost)
                              .reduce((v1, v2) => v1 + v2) /
                          data.length,
                    ),
                  ],
                ),
              ),
              const Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: CostChartControllerView(),
                  )),
              Expanded(flex: 1, child: Container()),
            ],
          );
        }));
  }
}
