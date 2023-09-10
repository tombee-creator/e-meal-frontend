import 'package:emeal_app/views/pages/ingredient_page.dart';
import 'package:emeal_app/views/pages/meal_preps_page.dart';
import 'package:flutter/material.dart';
import 'package:emeal_app/services/authentication.dart';
import 'package:emeal_app/views/auth/login_page.dart';
import 'package:emeal_app/views/auth/signup_page.dart';
import 'package:emeal_app/views/pages/meal_page.dart';

import '../pages/home_page.dart';

/// flutterアプリのルートを作成するクラス
class ApiRouter {
  ApiRouter? _instance;

  factory() => _instance ??= ApiRouter();

  static const String root = '/';
  static const String home = '/home';
  static const String ingredient = '/ingredients';
  static const String prep = '/preps';
  static const String recipe = '/meals';
  static const String login = '/login';
  static const String signup = '/signup';

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case root:
        return MaterialPageRoute(
            builder: (context) => redirect(context), settings: settings);
      case home:
        return MaterialPageRoute(
            builder: (_) => const HomePage(title: "e-Meal"),
            settings: settings);
      case prep:
        return MaterialPageRoute(
            builder: (_) => const MealPrepsPage(title: "e-Meal"),
            settings: settings);
      case ingredient:
        return MaterialPageRoute(
            builder: (_) => const IngredientPage(title: "e-Meal"),
            settings: settings);
      case recipe:
        return MaterialPageRoute(
            builder: (_) => const MealPage(title: "e-Meal"),
            settings: settings);
      case login:
        return MaterialPageRoute(
            builder: (_) => const LoginPage(), settings: settings);
      case signup:
        return MaterialPageRoute(
            builder: (_) => const SignupPage(), settings: settings);
      default:
        return MaterialPageRoute(
          builder: (context) => redirect(context),
        );
    }
  }

  Widget redirect(BuildContext context) {
    final auth = Authentication();
    if (auth.isAuthenticated) {
      return const HomePage(title: "e-Meal");
    } else {
      return const LoginPage();
    }
  }
}
