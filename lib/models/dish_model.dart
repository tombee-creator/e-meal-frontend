import 'package:firebase_auth/firebase_auth.dart';

class DishModel {
  final User userId;
  final String title;
  final String description;
  final String url;

  DishModel(this.userId, this.title, this.description, this.url);
}
