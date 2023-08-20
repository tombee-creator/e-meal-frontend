import 'package:emeal_app/models/home_menu_model.dart';
import 'package:flutter/material.dart';
import 'package:emeal_app/views/home/components/home_component.dart';
import 'package:emeal_app/views/home/components/post/post_view.dart';
import 'package:emeal_app/views/profile/profile_component.dart';
import 'package:emeal_app/views/home/home_page_layout.dart';

class HomePage extends StatelessWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return HomePageLayout(
      title: "e-Meal",
      menu: [
        HomeMenuModel("ホーム", Icons.home_filled),
        HomeMenuModel("作り置き管理", Icons.inventory),
        HomeMenuModel("食事", Icons.lunch_dining),
        HomeMenuModel("プロフィール", Icons.person)
      ],
      screens: const <Widget>[
        HomeComponent(),
        Text("インベントリ"),
        PostView(),
        ProfileComponent()
      ],
    );
  }
}
