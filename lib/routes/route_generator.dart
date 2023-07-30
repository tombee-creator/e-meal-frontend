import 'package:flutter/material.dart';
import 'package:frontend/views/login.dart';

import '../views/my_home_page.dart';

/// flutterアプリのルートを作成するクラス
class RouteGenerator {
  RouteGenerator? _instance;

  factory() => _instance ??= RouteGenerator();

  // 各ページを定義
  static const String home = '/';
  static const String login = '/login';

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const MyHomePage(title: "つみたべ"),
        );
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );
      default:
        throw Exception('Route not found');
    }
  }
}
