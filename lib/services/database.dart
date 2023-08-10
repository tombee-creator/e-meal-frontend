import 'package:frontend/services/authentication.dart';

import '../models/recipe_model.dart';

class Database {
  Database? _instance;

  factory() => _instance ??= Database();

  Future<List<RecipeModel>> getDishes() async {
    await Future.delayed(const Duration(seconds: 3));
    return List.generate(30, (index) => index)
        .map(
          (index) => RecipeModel(
              Authentication().currentUser,
              "テスト${index + 1}",
              "テスト説明${index + 1}",
              "https://picsum.photos/seed/picsum/640/640/?blur"),
        )
        .toList();
  }
}
