import 'package:flutter/material.dart';
import 'package:emeal_app/services/authentication.dart';
import 'package:emeal_app/views/auth/login_page.dart';
import 'package:emeal_app/views/auth/signup_page.dart';
import 'package:emeal_app/views/pages/recipe_page.dart';

import '../pages/home_page.dart';

/// flutterアプリのルートを作成するクラス
class ApiRouter {
  ApiRouter? _instance;

  factory() => _instance ??= ApiRouter();

  // 各ページを定義
  static const String root = '/';
  static const String home = '/home';
  static const String recipe = '/meals';
  static const String login = '/login';
  static const String signup = '/signup';

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case root:
        return MaterialPageRoute(
          builder: (context) => redirect(context),
        );
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomePage(title: "e-Meal"),
        );
      case recipe:
        return MaterialPageRoute(
          builder: (_) => const MealPage(title: "e-Meal"),
        );
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );
      case signup:
        return MaterialPageRoute(
          builder: (_) => const SignupPage(),
        );
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
