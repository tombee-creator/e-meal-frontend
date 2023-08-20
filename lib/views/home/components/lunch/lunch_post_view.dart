import 'dart:io';

import 'package:flutter/material.dart';
import 'package:emeal_app/helper/image_picker_provider.dart';
import 'package:emeal_app/views/home/components/lunch/recipe_field_form.dart';
import 'package:emeal_app/views/home/components/lunch/recipe_post_button.dart';

class LunchPostView extends StatefulWidget {
  const LunchPostView({super.key});

  @override
  State<StatefulWidget> createState() => _LunchPostViewState();
}

class _LunchPostViewState extends State<LunchPostView> {
  double cost = 0.0;
  String comment = "";
  File? image;

  @override
  Widget build(BuildContext context) {
    final imageWidget = image == null
        ? const Icon(Icons.camera)
        : Image.file(image!, fit: BoxFit.cover);
    return Column(
      children: [
        Center(
          child: AspectRatio(
              aspectRatio: 1.0,
              child: GestureDetector(
                  onTap: () async {
                    getImage();
                  },
                  child: imageWidget)),
        ),
        RecipeFieldForm(
          hintText: "コメント",
          icon: Icons.description,
          onChange: (comment) {
            setState(() {
              this.comment = comment;
            });
          },
        ),
        RecipeFieldForm(
          hintText: "コスト",
          icon: Icons.currency_yen,
          onChange: (cost) {
            final parsedCost = double.tryParse(cost) ?? 0.0;
            setState(() {
              this.cost = parsedCost;
            });
          },
        ),
        const Spacer(),
        RecipePostButton(
          comment: comment,
          image: image,
          cost: cost,
        )
      ],
    );
  }

  Future getImage() async {
    final provider = ImagePickerProvider();
    provider.getImage((image) {
      setState(() {
        this.image = image;
      });
    });
  }
}
