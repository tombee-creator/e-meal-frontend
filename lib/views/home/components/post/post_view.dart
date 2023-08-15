import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tsumitabe_app/helper/image_picker_provider.dart';
import 'package:tsumitabe_app/views/home/components/post/recipe_field_form.dart';
import 'package:tsumitabe_app/views/home/components/post/recipe_post_button.dart';

class PostView extends StatefulWidget {
  const PostView({super.key});

  @override
  State<StatefulWidget> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
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
