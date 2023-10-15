import 'dart:io';
import 'package:emeal_app/models/ingredient/ingredient_post_data.dart';
import 'package:emeal_app/models/ingredient/used_ingredient_info.dart';
import 'package:emeal_app/services/database.dart';
import 'package:emeal_app/services/emeal_crud_api.dart';
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
  late List<UsedIngredientPostInfo> selected;

  @override
  void initState() {
    super.initState();

    ingredients = <Ingredient>[];
    selected = <UsedIngredientPostInfo>[];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(children: [
        Container(
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black12))),
            height: 72.0,
            child: topBanner()),
        Expanded(child: body(context))
      ]),
      Positioned(
          right: 20.0,
          bottom: 20.0,
          child: FloatingActionButton(
              onPressed: selected.isNotEmpty
                  ? () {
                      pushPurchases()
                          .then((value) => Navigator.of(context).pop());
                    }
                  : null,
              child: const Icon(Icons.upload)))
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

  Future pushPurchases() async {
    final api = Database().provider(
        EMealCrudApi<Ingredient>(Ingredient.collection, Ingredient.fromJson));
    for (var usedInfo in selected) {
      final item = usedInfo.ingredient;
      final result = await api.post((id) => IngredientPostData(
          id,
          FirebaseUser.from(Authentication().currentUser),
          item.name,
          item.url,
          item.cost,
          item.times,
          item.category,
          false,
          DateTime.now(),
          DateTime.now(),
          0, []).toJson());
      if (result == null) {
        continue;
      }
      setState(() {
        ingredients = ingredients
            .where((element) => element.name != result.name)
            .toList();
      });
    }
  }

  Widget body(BuildContext context) {
    if (ingredients.isEmpty) {
      return IconButton(
          onPressed: onPressed, icon: const Icon(Icons.camera_alt));
    }
    return ListView.separated(
        itemBuilder: (context, index) => IngredientForm(
            isChecked: selected
                .where(
                    (info) => info.ingredient.name == ingredients[index].name)
                .isNotEmpty,
            ingredient: ingredients[index],
            onCheckboxChanged: (ingredient) {
              final items = selected
                  .where((item) => item.ingredient.name == ingredient.name);
              if (items.isEmpty) {
                setState(() {
                  selected.add(UsedIngredientPostInfo(
                      ingredient: ingredient, isUsedUp: false, count: 0));
                });
              } else {
                setState(() {
                  selected = selected
                      .where((item) => item.ingredient.name != ingredient.name)
                      .toList();
                });
              }
            }),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: ingredients.length);
  }

  Widget topBanner() {
    return Row(children: [
      Expanded(
          flex: 1, child: Checkbox(value: false, onChanged: (isChecked) {})),
      Expanded(
          flex: 7,
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            IconButton.filled(
                onPressed: () {
                  setState(() {
                    ingredients.add(Ingredient(
                        "",
                        FirebaseUser.from(Authentication().currentUser),
                        "",
                        "",
                        0.0,
                        1,
                        Category.ingredient,
                        false,
                        DateTime.now(),
                        DateTime.now(),
                        0));
                  });
                },
                icon: const Icon(Icons.add))
          ]))
    ]);
  }
}
