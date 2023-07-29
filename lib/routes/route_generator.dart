import 'package:flutter/material.dart';

import '../views/my_home_page.dart';

class RouteGenerator {
  // 各ページを定義
  static const String home = '/';
  static const String hoge = '/hoge';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const MyHomePage(title: "つみたべ"),
        );
      default:
        // 非該当時のエラー
        throw Exception('Route not found');
    }
  }
}
