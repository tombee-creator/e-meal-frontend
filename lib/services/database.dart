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
              "aaaaa",
              Authentication().currentUser,
              "テスト${index + 1}",
              "テスト説明${index + 1}",
              "https://picsum.photos/id/${index + 1}/640/640/?blur"),
        )
        .toList();
  }

  Future<RecipeModel> getDishItem(String id) async {
    await Future.delayed(const Duration(seconds: 3));
    return RecipeModel("aaaaa", Authentication().currentUser, id, "テスト説明（$id）",
        "https://picsum.photos/id/100/640/640/?blur");
  }
}
