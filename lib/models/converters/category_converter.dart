import 'package:emeal_app/models/ingredient/ingredient.dart';

class CategoryConverter {
  const CategoryConverter();

  Category valueOf(int index) {
    return Category.values[index];
  }

  int indexOf(Category category) {
    return Category.values.indexOf(category);
  }

  String nameOf(Category category) {
    return category.toString().split(".").last;
  }
}
