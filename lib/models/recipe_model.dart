import 'package:firebase_auth/firebase_auth.dart';

class RecipeModel {
  final String id;
  final User user;
  final String title;
  final String description;
  final String url;

  RecipeModel(this.id, this.user, this.title, this.description, this.url);
}
