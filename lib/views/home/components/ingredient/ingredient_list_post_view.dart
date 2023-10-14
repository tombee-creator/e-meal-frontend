import 'dart:io';
import 'package:flutter/material.dart';

import 'package:emeal_app/models/firebase_user/firebase_user.dart';
import 'package:emeal_app/models/ingredient/ingredient.dart';
import 'package:emeal_app/services/authentication.dart';
import 'package:emeal_app/services/emeal_http_client.dart';
import 'package:emeal_app/views/home/components/ingredient/form/ingredient_form.dart';
import 'package:image_picker/image_picker.dart';

class IngredientListPostView extends StatefulWidget {
  const IngredientListPostView({super.key});

  @override
  State<StatefulWidget> createState() => IngredientListPostViewState();
}

class IngredientListPostViewState extends State<IngredientListPostView> {
  late List<Ingredient> ingredients;

  @override
  void initState() {
    super.initState();

    ingredients = <Ingredient>[];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ListView.separated(
          itemBuilder: (context, index) => IngredientForm(
              isChecked: false,
              ingredient: ingredients[index],
              onCheckboxChanged: (item) {}),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: ingredients.length),
      Positioned(
          right: 20.0,
          bottom: 20.0,
          child: FloatingActionButton(
              onPressed: onPressed, child: const Icon(Icons.receipt)))
    ]);
  }

  Future onPressed() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final imageFile = File(image.path);
      final data = await EMealHttpClient().getRecipeData(imageFile);
      setState(() {
        final purchases = data.map((item) {
          final purchase = item as Map<String, dynamic>;
          return Ingredient(
              "",
              FirebaseUser.from(Authentication().currentUser),
              purchase["name"],
              "",
              (purchase["cost"] as num).toDouble(),
              0,
              Category.ingredient,
              false,
              DateTime.now(),
              DateTime.now(),
              0);
        }).toList();
        for (var purchase in purchases) {
          ingredients.add(purchase);
        }
      });
    }
  }
}
