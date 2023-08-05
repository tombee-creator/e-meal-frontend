import 'package:flutter/material.dart';

class ProfileTextComponent extends StatelessWidget {
  final IconData icon;
  final Widget child;

  const ProfileTextComponent(
      {super.key, required this.icon, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Icon(icon), child]),
    );
  }
}
