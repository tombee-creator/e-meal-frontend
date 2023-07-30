import 'package:flutter/material.dart';
import 'package:frontend/services/authentication.dart';
import 'package:frontend/views/login.dart';

import '../views/my_home_page.dart';

/// flutterアプリのルートを作成するクラス
class RouteGenerator {
  RouteGenerator? _instance;

  factory() => _instance ??= RouteGenerator();

  // 各ページを定義
  static const String root = '/';
  static const String home = '/home';
  static const String login = '/login';

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case root:
        return MaterialPageRoute(
          builder: (context) => redirect(context),
        );
      case home:
        return MaterialPageRoute(
          builder: (_) => const MyHomePage(title: "つみたべ"),
        );
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
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
      return const MyHomePage(title: "つみたべ");
    } else {
      return const LoginPage();
    }
  }
}
