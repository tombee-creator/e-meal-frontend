import 'package:emeal_app/models/meal/meal.dart';

class MealConverter {
  const MealConverter();

  static Meal fromJson(Map<String, dynamic> data) => Meal.fromJson(data);

  static String toJson(Meal object) => object.id;
}
