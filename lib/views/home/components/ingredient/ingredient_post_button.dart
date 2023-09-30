import 'package:flutter/material.dart';
import 'package:emeal_app/models/ingredient/ingredient_post_data.dart';
import 'package:emeal_app/models/ingredient/used_ingredient_info.dart';
import 'package:emeal_app/views/common/alert_view.dart';
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
  final Category category;

  const IngredientPostButton(
      {super.key,
      required this.name,
      required this.cost,
      required this.times,
      required this.category});

  @override
  State<StatefulWidget> createState() => _IngredientPostButtonState();
}

class _IngredientPostButtonState extends State<IngredientPostButton> {
  String path = "";
  double progress = 0.0;
  ButtonState state = ButtonState.wating;
  List<UsedIngredientPostInfo> selected = [];

  bool get _isEnabled {
    return state == ButtonState.wating && widget.name.isNotEmpty;
  }

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments as Map;
    selected = (args['ingredients'] ?? []) as List<UsedIngredientPostInfo>;

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
            widget.category,
            false,
            DateTime.now(),
            DateTime.now(),
            0,
            selected)
        .toJson());
  }

  Future<bool> confirmUsedUp() async {
    for (final item in selected) {
      if (item.isUsedUp) {
        final result = await AlertView()
            .show(context, body: "${item.ingredient.name}を使い切ります。\nよろしいですか？");
        if (!result) {
          return false;
        }
      }
    }
    return true;
  }
}
