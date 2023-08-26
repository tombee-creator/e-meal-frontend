import 'package:emeal_app/models/ingredient.dart';
import 'package:emeal_app/models/meal_prep.dart';
import 'package:emeal_app/services/database.dart';
import 'package:emeal_app/services/firestore_crud_api.dart';

class IngredientConverter {
  const IngredientConverter();

  static Future<Ingredient?> fromJson(String id) async {
    final api = Database().provider(
        FirestoreCRUDApi<Ingredient>(MealPrep.collection, Ingredient.fromJson));
    final item = await api.get(id);
    return item;
  }

  static String toJson(Ingredient ingredient) => ingredient.id;
}
