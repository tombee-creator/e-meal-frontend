import 'package:emeal_app/models/ingredient/ingredient.dart';
import 'package:emeal_app/models/meal_prep/meal_prep.dart';

class UsedIngredientData {
  final Ingredient ingredient;
  final bool isUsedUp;
  final int count;
  final MealPrep? prep;

  UsedIngredientData(
      {required this.ingredient,
      required this.isUsedUp,
      required this.count,
      this.prep});

  Map<String, dynamic> toJson() {
    return {
      "ingredient": ingredient.id,
      "is_used_up": isUsedUp.toString(),
      "count": count.toString()
    };
  }

  static List<UsedIngredientData> create(List<Ingredient> ingredients) {
    final ret = <UsedIngredientData>[];
    final ids = ingredients.map((item) => item.id).toSet();
    for (final id in ids) {
      final items = ingredients.where((ingredient) => ingredient.id == id);
      final item = items.last;
      ret.add(UsedIngredientData(
          ingredient: item, isUsedUp: item.isUsedUp, count: items.length));
    }
    return ret;
  }
}
