import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:emeal_app/models/meal.dart';

class CostChartView extends StatelessWidget {
  final List<Meal> meals;
  final DateTime focus;

  const CostChartView({super.key, required this.meals, required this.focus});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: BarTouchData(
          enabled: false,
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: bottomTitles,
                reservedSize: 42),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: leftTitles,
            ),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        gridData: const FlGridData(
          show: false,
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barGroups: getData(32.0, 20.0),
      ),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final dateList =
        List.generate(7, (index) => focus.add(Duration(days: -index)))
            .reversed
            .toList();
    const style = TextStyle(fontSize: 10);
    final date = dateList[value.toInt()];
    final weekdayName = weekdayNameFrom(date.weekday);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('${date.month}/${date.day}', style: style),
          Text(weekdayName, style: style),
        ],
      ),
    );
  }

  String weekdayNameFrom(int weekday) => switch (weekday) {
        1 => "月",
        2 => "火",
        3 => "水",
        4 => "木",
        5 => "金",
        6 => "土",
        7 => "日",
        _ => ""
      };

  Widget leftTitles(double value, TitleMeta meta) {
    if (value == meta.max) {
      return Container();
    }
    const style = TextStyle(
      fontSize: 10,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        meta.formattedValue,
        style: style,
      ),
    );
  }

  List<BarChartGroupData> getData(double barsWidth, double barsSpace) {
    final dateList =
        List.generate(7, (index) => focus.add(Duration(days: -index)))
            .reversed
            .toList();
    final list = dateList
        .map((date) =>
            meals.where((recipe) => isSameDay(recipe.created, date)).toList())
        .toList();
    return list.asMap().entries.map((entry) {
      final rodData = generateRodData(entry.value);
      return BarChartGroupData(
        x: entry.key,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
              toY: maxCostInWeek(),
              rodStackItems: rodData,
              borderRadius: BorderRadius.zero,
              width: barsWidth,
              color: Colors.transparent),
        ],
      );
    }).toList();
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.difference(b).inDays == 0 && a.day == b.day;
  }

  double maxCostInWeek() {
    final dateList = meals
        .map((recipe) => DateTime(
            recipe.created.year, recipe.created.month, recipe.created.day))
        .toSet();
    final list = dateList
        .map((date) =>
            meals.where((recipe) => isSameDay(recipe.created, date)).toList())
        .map((items) => items.map((item) => item.cost))
        .map((items) => items.reduce((a1, a2) => a1 + a2))
        .toList();
    return list.reduce(max);
  }

  List<BarChartRodStackItem> generateRodData(List<Meal> items) {
    final list = <BarChartRodStackItem>[];
    if (items.isNotEmpty) {
      final colors = [
        Colors.black,
        Colors.black12,
      ];
      var cost = 0.0;
      for (final i in List.generate(items.length, (index) => index)) {
        list.add(
            BarChartRodStackItem(cost, cost + items[i].cost, colors[i % 2]));
        cost += items[i].cost;
      }
    }
    return list;
  }
}
