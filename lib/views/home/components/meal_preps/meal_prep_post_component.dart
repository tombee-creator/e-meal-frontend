import 'dart:io';

import 'package:flutter/material.dart';

class MealPrepPostComponent extends StatefulWidget {
  const MealPrepPostComponent({super.key});

  @override
  State<StatefulWidget> createState() => _MealPrepPostComponentState();
}

class _MealPrepPostComponentState extends State<MealPrepPostComponent> {
  File? sourceImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1.0,
          child: GestureDetector(
            child: thumbnail(),
          ),
        )
      ],
    );
  }

  Widget thumbnail() {
    final file = sourceImage;
    if (file == null) {
      return const Center(
        child: Icon(Icons.camera),
      );
    } else {
      return Image.file(file);
    }
  }
}
