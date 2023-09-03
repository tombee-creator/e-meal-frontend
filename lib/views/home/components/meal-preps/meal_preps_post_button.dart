import 'package:emeal_app/models/firebase_user.dart';
import 'package:emeal_app/models/ingredient.dart';
import 'package:emeal_app/models/meal_prep.dart';
import 'package:emeal_app/models/prep_ingredient_relationship.dart';
import 'package:emeal_app/services/emeal_crud_api.dart';
import 'package:flutter/material.dart';
import 'package:emeal_app/services/authentication.dart';
import 'package:emeal_app/services/database.dart';
import 'package:emeal_app/services/firestore_crud_api.dart';

enum ButtonState { wating, uploadImage, postData, success, failed }

class MealPrepPostButton extends StatefulWidget {
  final String name;
  final double cost;
  final int times;
  final List<Ingredient> ingredients;

  const MealPrepPostButton(
      {super.key,
      required this.name,
      required this.cost,
      required this.times,
      required this.ingredients});

  @override
  State<StatefulWidget> createState() => _MealPrepPostButtonState();
}

class _MealPrepPostButtonState extends State<MealPrepPostButton> {
  String path = "";
  double progress = 0.0;
  ButtonState state = ButtonState.wating;

  bool get _isEnabled {
    return state == ButtonState.wating &&
        widget.name.isNotEmpty &&
        widget.cost != 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton.icon(
      icon: getIcon(),
      label: const Text("投稿"),
      onPressed: _isEnabled ? postRecipe : null,
    ));
  }

  Widget getIcon() {
    return Container(
        child: switch (state) {
      ButtonState.wating => const Icon(Icons.post_add),
      ButtonState.uploadImage => CircularProgressIndicator(value: progress),
      ButtonState.postData => const CircularProgressIndicator(),
      ButtonState.success => const Icon(Icons.check),
      ButtonState.failed => const Icon(Icons.close)
    });
  }

  Future postRecipe() async {
    final isConfirmed = await confirmUsedUp();
    if (!isConfirmed) {
      return;
    }
    setState(() {
      state = ButtonState.postData;
    });
    final mealPrep = await postRecipeData("");
    if (mealPrep == null) {
      setState(() {
        state = ButtonState.failed;
      });
      return;
    }
    await postIngredientListData(mealPrep);
    setState(() {
      state = ButtonState.success;
    });
    Future.delayed(const Duration(seconds: 1))
        .then((value) => Navigator.of(context).pop());
  }

  Future<MealPrep?> postRecipeData(String url) async {
    final api = Database().provider(
        FirestoreCRUDApi<MealPrep>(MealPrep.collection, MealPrep.fromJson));
    return await api.post((id) => MealPrep(
            id,
            FirebaseUser.from(Authentication().currentUser),
            widget.name,
            url,
            widget.cost,
            widget.times,
            false,
            DateTime.now(),
            DateTime.now(),
            0)
        .toJson());
  }

  postIngredientListData(MealPrep mealPrep) async {
    final api = Database().provider(FirestoreCRUDApi<PrepIngredientRelation>(
        PrepIngredientRelation.collection, PrepIngredientRelation.fromJson));
    final ids = widget.ingredients.map((item) => item.id).toSet();
    for (final id in ids) {
      final list = widget.ingredients.where((item) => item.id == id);
      final item = list.last;
      await putIngredient(item);
      await api.post((id) => PrepIngredientRelation(
              id,
              FirebaseUser.from(Authentication().currentUser),
              item,
              mealPrep,
              list.length,
              DateTime.now(),
              DateTime.now())
          .toJson());
    }
  }

  Future<void> putIngredient(Ingredient ingredient) async {
    final api = Database().provider(
        EMealCrudApi<Ingredient>(Ingredient.collection, Ingredient.fromJson));
    await api.put(ingredient.id, ingredient, (item) => item.toJson());
  }

  Future<bool> confirmUsedUp() async {
    final ids = widget.ingredients.map((item) => item.id).toSet();
    for (final id in ids) {
      final list = widget.ingredients.where((item) => item.id == id);
      final item = list.last;
      if (item.isUsedUp) {
        final result = await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) => AlertDialog(
                  title: const Text("確認"),
                  content: Text("${item.name}を使い切ります。\nよろしいですか？"),
                  actions: [
                    TextButton(
                        child: const Text("OK"),
                        onPressed: () {
                          Navigator.pop(context, true);
                        }),
                    TextButton(
                        child: const Text("Cancel"),
                        onPressed: () {
                          Navigator.pop(context, false);
                        })
                  ],
                ));
        if (!result) {
          return false;
        }
      }
    }
    return true;
  }
}
