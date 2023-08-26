import 'dart:io';
import 'package:emeal_app/models/ingredient.dart';
import 'package:emeal_app/models/meal_prep.dart';
import 'package:emeal_app/models/prep_ingredient_relationship.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:emeal_app/services/authentication.dart';
import 'package:emeal_app/services/database.dart';
import 'package:emeal_app/services/firestore_crud_api.dart';

enum ButtonState { wating, uploadImage, postData, success, failed }

class MealPrepPostButton extends StatefulWidget {
  final String name;
  final double cost;
  final int times;
  final File? image;
  final List<Ingredient> ingredients;

  const MealPrepPostButton(
      {super.key,
      required this.name,
      required this.cost,
      required this.times,
      required this.image,
      required this.ingredients});

  @override
  State<StatefulWidget> createState() => _MealPrepPostButtonState();
}

class _MealPrepPostButtonState extends State<MealPrepPostButton> {
  String path = "";
  double progress = 0.0;
  ButtonState state = ButtonState.wating;

  bool get _isEnabled {
    return widget.image != null &&
        state == ButtonState.wating &&
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
    setState(() {
      state = ButtonState.uploadImage;
    });
    final url = await uploadImageFile();
    setState(() {
      state = ButtonState.postData;
    });
    final mealPrep = await postRecipeData(url);
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

  Future<String> uploadImageFile() async {
    try {
      final fileBaseName =
          "${const Uuid().v4()}-${DateTime.now().toIso8601String()}";
      final storage = FirebaseStorage.instance.ref("$fileBaseName.png");
      final image = widget.image;
      if (image == null) {
        throw UnsupportedError("画像が指定されていません");
      }
      final metadata = SettableMetadata(contentType: "image/png");
      final uploadTask = storage.putFile(image, metadata);
      uploadTask.snapshotEvents.listen((snapshot) {
        switch (snapshot.state) {
          case TaskState.running:
            setState(() {
              progress =
                  snapshot.bytesTransferred.toDouble() / snapshot.totalBytes;
            });
            break;
          case TaskState.paused:
            // ...
            break;
          case TaskState.success:
            print(storage.name);
            print(storage.fullPath);
            break;
          case TaskState.canceled:
            // ...
            break;
          case TaskState.error:
            print(snapshot);
            break;
        }
      });
      final imgUrl = await (await uploadTask).ref.getDownloadURL();
      return "${imgUrl.replaceAll(Uri.parse(imgUrl).query, "")}alt=media";
    } catch (e) {
      rethrow;
    }
  }

  Future<MealPrep?> postRecipeData(String url) async {
    final api = Database().provider(
        FirestoreCRUDApi<MealPrep>(MealPrep.collection, MealPrep.fromJson));
    return await api.post((id) => MealPrep(
            id,
            Authentication().currentUser,
            widget.name,
            url,
            widget.cost,
            widget.times,
            false,
            DateTime.now(),
            DateTime.now())
        .toJson());
  }

  postIngredientListData(MealPrep mealPrep) async {
    final api = Database().provider(
        FirestoreCRUDApi<Future<PrepIngredientRelation>>(
            PrepIngredientRelation.collection,
            PrepIngredientRelation.fromJson));
    final ids = widget.ingredients.map((item) => item.id).toSet();
    for (final id in ids) {
      final list = widget.ingredients.where((item) => item.id == id);
      final item = list.first;
      await api.post((id) => PrepIngredientRelation(
              id,
              Authentication().currentUser,
              item,
              mealPrep,
              list.length,
              DateTime.now(),
              DateTime.now())
          .toJson());
    }
  }
}
