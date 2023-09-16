import 'package:emeal_app/models/ingredient/ingredient.dart';

class IngredientTypeConverter {
  const IngredientTypeConverter();

  Category valueOf(int index) {
    return Category.values[index];
  }

  int indexOf(Category type) {
    return Category.values.indexOf(type);
  }
}
