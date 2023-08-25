import 'package:flutter/material.dart';

class MealFieldForm extends StatelessWidget {
  final String hintText;
  final IconData? icon;
  final void Function(String) onChange;

  const MealFieldForm({
    super.key,
    required this.hintText,
    required this.onChange,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: TextField(
          onChanged: onChange,
          decoration:
              InputDecoration(hintText: hintText, prefixIcon: Icon(icon)),
        ));
  }
}
