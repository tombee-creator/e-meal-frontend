import 'package:firebase_auth/firebase_auth.dart';

class RecipeModel {
  final User userId;
  final String title;
  final String description;
  final String url;

  RecipeModel(this.userId, this.title, this.description, this.url);
}
