import 'package:flutter/material.dart';

class MaterialPostView extends StatefulWidget {
  const MaterialPostView({super.key});

  @override
  State<StatefulWidget> createState() => _MaterialPostViewState();
}

class _MaterialPostViewState extends State<MaterialPostView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("素材"),
    );
  }
}
