import 'package:flutter/material.dart';
import 'package:frontend/services/authentication.dart';
import 'package:frontend/views/auth/login_page.dart';
import 'package:frontend/views/auth/signup_page.dart';

import '../my_home_page.dart';

/// flutterアプリのルートを作成するクラス
class RouteGenerator {
  RouteGenerator? _instance;

  factory() => _instance ??= RouteGenerator();

  // 各ページを定義
  static const String root = '/';
  static const String home = '/home';
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
          builder: (_) => const HomePage(title: "つみたべ"),
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
      return const HomePage(title: "つみたべ");
    } else {
      return const LoginPage();
    }
  }
}
