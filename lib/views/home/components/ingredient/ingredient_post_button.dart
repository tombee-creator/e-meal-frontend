import 'package:emeal_app/models/ingredient/ingredient_post_data.dart';
import 'package:emeal_app/models/ingredient/used_ingredient_info.dart';
import 'package:flutter/material.dart';
import 'package:emeal_app/models/firebase_user/firebase_user.dart';
import 'package:emeal_app/models/ingredient/ingredient.dart';
import 'package:emeal_app/services/emeal_crud_api.dart';
import 'package:emeal_app/services/authentication.dart';
import 'package:emeal_app/services/database.dart';

enum ButtonState { wating, uploadImage, postData, success, failed }

class IngredientPostButton extends StatefulWidget {
  final String name;
  final double cost;
  final int times;

  const IngredientPostButton(
      {super.key, required this.name, required this.cost, required this.times});

  @override
  State<StatefulWidget> createState() => _IngredientPostButtonState();
}

class _IngredientPostButtonState extends State<IngredientPostButton> {
  String path = "";
  double progress = 0.0;
  ButtonState state = ButtonState.wating;
  Category category = Category.ingredient;
  List<Ingredient> selected = [];

  bool get _isEnabled {
    return state == ButtonState.wating && widget.name.isNotEmpty;
  }

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments as Map;
    category = args['category'] ?? Category.ingredient;
    selected = args['ingredients'] ?? [];
    super.didChangeDependencies();
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
      state = ButtonState.uploadImage;
    });
    await postRecipeData("");
    setState(() {
      state = ButtonState.success;
    });
    Future.delayed(const Duration(seconds: 1))
        .then((value) => Navigator.of(context).pop());
  }

  Future postRecipeData(String url) async {
    final api = Database().provider(
        EMealCrudApi<Ingredient>(Ingredient.collection, Ingredient.fromJson));

    await api.post((id) => IngredientPostData(
            id,
            FirebaseUser.from(Authentication().currentUser),
            widget.name,
            url,
            widget.cost,
            widget.times,
            category,
            false,
            DateTime.now(),
            DateTime.now(),
            0,
            UsedIngredientPostInfo.create(selected))
        .toJson());
  }

  Future<bool> confirmUsedUp() async {
    final ids = selected.map((item) => item.id).toSet();
    for (final id in ids) {
      final list = selected.where((item) => item.id == id);
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
