import 'package:flutter/material.dart';
import 'package:tsumitabe_app/views/home/components/home_component.dart';
import 'package:tsumitabe_app/views/home/components/post/post_view.dart';
import 'package:tsumitabe_app/views/profile/profile_component.dart';
import 'package:tsumitabe_app/views/home/home_page_layout.dart';

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
        HomeMenuModel("レシピ追加", Icons.add_outlined),
        HomeMenuModel("プロフィール", Icons.person)
      ],
      screens: const <Widget>[HomeComponent(), PostView(), ProfileComponent()],
    );
  }
}
