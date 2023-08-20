import 'package:flutter/material.dart';
import 'package:emeal_app/models/recipe.dart';

class CostDescriptionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final double value;

  const CostDescriptionItem(
      {super.key,
      required this.icon,
      required this.label,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Column(
                  children: [
                    Icon(
                      icon,
                      size: 28.0,
                    ),
                    Text(
                      label,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12.0),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.currency_yen),
                    Text(
                      value.toStringAsFixed(1),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 24.0),
                    )
                  ],
                ),
              ],
            )));
  }

  static CostDescriptionItem generate(
      {required List<Recipe> data,
      required IconData icon,
      required String label,
      required double Function(List<Recipe> data) value}) {
    return CostDescriptionItem(
      icon: icon,
      label: label,
      value: data.isNotEmpty ? value(data) : 0.0,
    );
  }
}
