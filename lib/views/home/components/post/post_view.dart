import 'package:flutter/material.dart';
import 'package:frontend/models/recipe.dart';
import 'package:frontend/services/authentication.dart';
import 'package:frontend/services/database.dart';
import 'package:frontend/helper/crud_api.dart';

class PostView extends StatelessWidget {
  const PostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
      onPressed: () async {
        final api =
            Database().provider(CRUDApi<Recipe>("recipes", Recipe.fromJson));
        await api.post((id) => Recipe(id, Authentication().currentUser, "title",
                "description", "https://picsum.photos/id/100/640/640/")
            .toJson());
      },
      child: const Text(
        "Add Recipe",
      ),
    ));
  }
}
