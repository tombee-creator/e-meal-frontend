import 'package:emeal_app/models/meal_prep.dart';

class MealPrepConverter {
  const MealPrepConverter();

  static MealPrep fromJson(Map<String, dynamic> data) =>
      MealPrep.fromJson(data);

  static String toJson(MealPrep object) => object.id;
}
