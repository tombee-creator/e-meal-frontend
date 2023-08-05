import 'package:flutter/material.dart';

class HomeComponent extends StatefulWidget {
  const HomeComponent({super.key});

  @override
  State<StatefulWidget> createState() => _HomeComponentState();
}

class _HomeComponentState extends State<HomeComponent> {
  @override
  Widget build(BuildContext context) {
    return const Padding(padding: EdgeInsets.all(10.0), child: Text("Test"));
  }
}
