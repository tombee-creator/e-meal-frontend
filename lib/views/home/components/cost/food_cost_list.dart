import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tsumitabe_app/models/recipe.dart';
import 'package:tsumitabe_app/views/home/components/cost/cost_description_item.dart.dart';

class FoodCostList extends StatelessWidget {
  final Future<List<Recipe>> future;

  const FoodCostList({super.key, required this.future});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: ((context, snapshot) {
          final data = snapshot.data ?? [];
          final sum = data.isNotEmpty
              ? data.map((item) => item.cost).reduce((v1, v2) => v1 + v2)
              : 0.0;
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CostDescriptionItem(
                    icon: Icons.calendar_month,
                    label: "今月の食費",
                    value: sum,
                  ),
                  CostDescriptionItem(
                    icon: Icons.attach_money,
                    label: "毎食費の平均",
                    value: sum / data.length,
                  ),
                ],
              ),
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: BarChart(
                      BarChartData(
                        borderData: FlBorderData(
                            border: const Border(
                          top: BorderSide.none,
                          right: BorderSide.none,
                          left: BorderSide(width: 1),
                          bottom: BorderSide(width: 1),
                        )),
                        groupsSpace: 10,
                        barGroups: data
                            .asMap()
                            .entries
                            .map((entry) =>
                                BarChartGroupData(x: entry.key, barRods: [
                                  BarChartRodData(
                                      toY: entry.value.cost, width: 15),
                                ]))
                            .toList(),
                      ),
                    ),
                  )),
              Expanded(flex: 1, child: Container()),
            ],
          );
        }));
  }
}
