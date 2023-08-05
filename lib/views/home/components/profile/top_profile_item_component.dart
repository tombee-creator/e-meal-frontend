import 'package:flutter/material.dart';

class TopProfileItemComponent extends StatelessWidget {
  final IconData icon;
  final String label;
  final int value;

  const TopProfileItemComponent(
      {super.key,
      required this.icon,
      required this.label,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                value.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ));
  }
}
