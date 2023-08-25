import 'dart:io';
import 'package:emeal_app/views/home/components/meal-preps/meal_preps_post_button.dart';
import 'package:flutter/material.dart';
import 'package:emeal_app/helper/image_picker_provider.dart';
import 'package:emeal_app/views/home/components/meal/meal_field_form.dart';

class MealPrepPostView extends StatefulWidget {
  const MealPrepPostView({super.key});

  @override
  State<StatefulWidget> createState() => _MealPrepPostViewState();
}

class _MealPrepPostViewState extends State<MealPrepPostView> {
  double cost = 0.0;
  int times = 1;
  String name = "";
  File? image;

  @override
  Widget build(BuildContext context) {
    final src = image;
    final imageWidget = src == null
        ? const Icon(Icons.camera)
        : Image.file(src, fit: BoxFit.cover);
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: GestureDetector(
                  onTap: () async {
                    getImage();
                  },
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: imageWidget,
                  )),
            ),
          ),
        ),
        Expanded(
            flex: 2,
            child: Column(
              children: [
                MealFieldForm(
                  hintText: "名前",
                  icon: Icons.description,
                  onChange: (name) {
                    setState(() {
                      this.name = name;
                    });
                  },
                ),
                MealFieldForm(
                  hintText: "コスト",
                  icon: Icons.currency_yen,
                  onChange: (cost) {
                    final parsedCost = double.tryParse(cost) ?? 0.0;
                    setState(() {
                      this.cost = parsedCost;
                    });
                  },
                ),
                MealFieldForm(
                  hintText: "使用回数",
                  icon: Icons.countertops,
                  onChange: (times) {
                    final parsedTimes = int.tryParse(times) ?? 1;
                    setState(() {
                      this.times = parsedTimes;
                    });
                  },
                ),
                const Spacer(),
                MealPrepPostButton(
                    name: name, image: image, cost: cost, times: times)
              ],
            ))
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
