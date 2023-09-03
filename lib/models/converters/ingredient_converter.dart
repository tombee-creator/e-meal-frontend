import 'package:emeal_app/models/ingredient.dart';

class IngredientConverter {
  const IngredientConverter();

  static Ingredient fromJson(Map<String, dynamic> data) =>
      Ingredient.fromJson(data);

  static String toJson(Ingredient object) => object.id;
}
