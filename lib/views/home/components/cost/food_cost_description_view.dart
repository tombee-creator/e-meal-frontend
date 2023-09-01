import 'package:emeal_app/services/database.dart';
import 'package:emeal_app/services/firestore_crud_api.dart';
import 'package:emeal_app/views/helper/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:emeal_app/models/meal.dart';
import 'package:emeal_app/views/home/components/cost/cost_chart_controller.dart';
import 'package:emeal_app/views/home/components/cost/cost_description_item.dart.dart';

class FoodCostDescriptionView extends StatefulWidget {
  const FoodCostDescriptionView({super.key});

  @override
  State<StatefulWidget> createState() => _FoodCostDescriptionViewState();
}

class _FoodCostDescriptionViewState extends State<FoodCostDescriptionView> {
  DateTime focus = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final api = Database()
        .provider(FirestoreCRUDApi<Meal>(Meal.collection, Meal.fromJson));
    final start = DateTime(focus.year, focus.month, 1);
    final end = DateTime(focus.year, focus.month + 1, 1);
    final displayedDate =
        DateFormatter().format(focus, type: DateFormatType.profileItem);
    return FutureBuilder(
        future: api.list(
            query: (ref) => ref.where("created",
                isGreaterThanOrEqualTo: start.toIso8601String(),
                isLessThanOrEqualTo: end.toIso8601String())),
        builder: ((context, snapshot) {
          final data = snapshot.data ?? [];
          return Column(
            children: [
              Text("$displayedDateの食費"),
              const Divider(),
              Row(
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
              const Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: CostChartControllerView(),
                  )),
            ],
          );
        }));
  }
}
