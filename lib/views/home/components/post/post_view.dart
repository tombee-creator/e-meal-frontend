import 'package:flutter/material.dart';
import 'package:frontend/models/recipe.dart';
import 'package:frontend/services/authentication.dart';

import '../../../../services/database.dart';

class PostView extends StatelessWidget {
  const PostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
      onPressed: () async {
        await Database().addRecipe(Recipe("aaaaa", Authentication().currentUser,
            "title", "description", "https://picsum.photos/id/100/640/640/"));
      },
      child: const Text(
        "Add Recipe",
      ),
    ));
  }
}
