import 'package:flutter/material.dart';

class MaterialsListView extends StatefulWidget {
  const MaterialsListView({super.key});

  @override
  State<StatefulWidget> createState() => _MaterialsListViewState();
}

class _MaterialsListViewState extends State<MaterialsListView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("リスト"),
    );
  }
}
