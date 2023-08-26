import 'package:emeal_app/models/ingredient.dart';
import 'package:emeal_app/models/meal_prep.dart';
import 'package:emeal_app/services/database.dart';
import 'package:emeal_app/services/firestore_crud_api.dart';

class MealPrepConverter {
  const MealPrepConverter();

  static Future<MealPrep?> fromJson(String id) async {
    final api = Database().provider(
        FirestoreCRUDApi<MealPrep>(MealPrep.collection, MealPrep.fromJson));
    final item = await api.get(id);
    return item;
  }

  static String toJson(Ingredient ingredient) => ingredient.id;
}
