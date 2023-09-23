import 'package:emeal_app/models/ingredient/ingredient.dart';

class UsedIngredientPostInfo {
  final Ingredient ingredient;
  bool isUsedUp;
  int count;

  UsedIngredientPostInfo(
      {required this.ingredient, required this.isUsedUp, required this.count});

  Map<String, dynamic> toJson() {
    return {
      "ingredient": ingredient.id,
      "is_used_up": isUsedUp,
      "count": count
    };
  }

  static List<UsedIngredientPostInfo> create(List<Ingredient> ingredients) {
    List<UsedIngredientPostInfo> data = [];
    final ids = ingredients.map((e) => e.id).toSet();
    for (final id in ids) {
      final items = ingredients.where((element) => element.id == id).toList();
      final item = items.last;
      final isUsedUp = item.isUsedUp;
      final count = items.length;
      data.add(UsedIngredientPostInfo(
          ingredient: item, isUsedUp: isUsedUp, count: count));
    }
    return data;
  }
}
