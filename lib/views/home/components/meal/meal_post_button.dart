import 'dart:io';
import 'package:emeal_app/models/firebase_user/firebase_user.dart';
import 'package:emeal_app/models/ingredient/ingredient.dart';
import 'package:emeal_app/models/ingredient/used_ingredient_info.dart';
import 'package:emeal_app/models/meal/meal.dart';
import 'package:emeal_app/models/meal/meal_post_data.dart';
import 'package:emeal_app/services/emeal_crud_api.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:emeal_app/services/authentication.dart';
import 'package:emeal_app/services/database.dart';

enum ButtonState { wating, uploadImage, postData, success, failed }

class MealPostButton extends StatefulWidget {
  final String comment;
  final double cost;
  final File? image;
  final List<Ingredient> preps;

  const MealPostButton(
      {super.key,
      required this.comment,
      required this.cost,
      required this.image,
      required this.preps});

  @override
  State<StatefulWidget> createState() => _MealPostButtonState();
}

class _MealPostButtonState extends State<MealPostButton> {
  String path = "";
  double progress = 0.0;
  ButtonState state = ButtonState.wating;

  bool get _isEnabled {
    return state == ButtonState.wating && widget.comment.isNotEmpty;
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
    final url = await uploadImageFile();
    if (Uri.parse(url).hasScheme) {
      setState(() {
        state = ButtonState.postData;
      });
    }
    final meal = await postRecipeData(url);
    if (meal == null) {
      setState(() {
        state = ButtonState.failed;
      });
      return;
    }
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
        return "";
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

  Future<Meal?> postRecipeData(String url) async {
    final api =
        Database().provider(EMealCrudApi<Meal>(Meal.collection, Meal.fromJson));
    return await api.post((id) => MealPostData(
            id,
            FirebaseUser.from(Authentication().currentUser),
            widget.comment,
            url,
            widget.cost,
            DateTime.now(),
            DateTime.now(),
            widget.preps,
            UsedIngredientPostInfo.create(widget.preps))
        .toJson());
  }

  Future<bool> confirmUsedUp() async {
    final ids = widget.preps.map((item) => item.id).toSet();
    for (final id in ids) {
      final list = widget.preps.where((item) => item.id == id);
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
