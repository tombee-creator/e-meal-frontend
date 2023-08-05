import 'package:flutter/material.dart';

class ProfileTextComponent extends StatelessWidget {
  final IconData icon;
  final String text;

  const ProfileTextComponent(
      {super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Icon(icon),
        Text(
          text,
          style: const TextStyle(fontSize: 16.0),
        )
      ]),
    );
  }
}
