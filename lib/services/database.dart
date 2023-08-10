import 'package:frontend/services/authentication.dart';

import '../models/dish_model.dart';

class Database {
  Database? _instance;

  factory() => _instance ??= Database();

  Future<List<DishModel>> getDishes() async {
    await Future.delayed(const Duration(seconds: 3));
    return List.generate(30, (index) => index)
        .map(
          (index) => DishModel(
              Authentication().currentUser,
              "テスト${index + 1}",
              "テスト説明${index + 1}",
              "https://picsum.photos/seed/picsum/640/640/?blur"),
        )
        .toList();
  }
}
