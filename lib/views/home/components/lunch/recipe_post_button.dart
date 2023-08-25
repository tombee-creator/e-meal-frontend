import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:emeal_app/models/recipe.dart';
import 'package:emeal_app/services/authentication.dart';
import 'package:emeal_app/services/database.dart';
import 'package:emeal_app/services/firestore_crud_api.dart';

enum ButtonState { wating, uploadImage, postData, success, failed }

class RecipePostButton extends StatefulWidget {
  final String comment;
  final double cost;
  final File? image;

  const RecipePostButton(
      {super.key,
      required this.comment,
      required this.cost,
      required this.image});

  @override
  State<StatefulWidget> createState() => _RecipePostButtonState();
}

class _RecipePostButtonState extends State<RecipePostButton> {
  String path = "";
  double progress = 0.0;
  ButtonState state = ButtonState.wating;

  bool get _isEnabled {
    return widget.image != null &&
        state == ButtonState.wating &&
        widget.comment.isNotEmpty &&
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
      ButtonState.postData => CircularProgressIndicator(),
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
      state = ButtonState.uploadImage;
    });
    await postRecipeData(url);
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
      return imgUrl.replaceAll(Uri.parse(imgUrl).query, "") + "alt=media";
    } catch (e) {
      rethrow;
    }
  }

  Future postRecipeData(String url) async {
    final api = Database()
        .provider(FirestoreCRUDApi<Recipe>("recipes", Recipe.fromJson));
    await api.post((id) => Recipe(id, Authentication().currentUser,
            widget.comment, url, widget.cost, DateTime.now(), DateTime.now())
        .toJson());
  }
}
