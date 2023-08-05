import 'package:flutter/material.dart';
import 'package:frontend/views/home/components/home_component.dart';
import 'package:frontend/views/home/components/profile_component.dart';
import 'package:frontend/views/home/home_page_layout.dart';

import '../../models/home_menu_model.dart';

class HomePage extends StatelessWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return HomePageLayout(
      title: "つみたべ",
      menu: [
        HomeMenuModel("ホーム", Icons.home_filled),
        HomeMenuModel("プロフィール", Icons.person)
      ],
      screens: const <Widget>[HomeComponent(), ProfileComponent()],
    );
  }
}
