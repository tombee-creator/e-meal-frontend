import 'package:emeal_app/models/home_menu_model.dart';
import 'package:emeal_app/views/home/components/meal_preps/meal_preps_component.dart';
import 'package:emeal_app/views/home/components/lunch/lunch_view.dart';
import 'package:flutter/material.dart';
import 'package:emeal_app/views/home/components/home_component.dart';
import 'package:emeal_app/views/profile/profile_component.dart';
import 'package:emeal_app/views/home/home_page_layout.dart';

enum PageState { post, list }

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageState pageState = PageState.post;

  @override
  Widget build(BuildContext context) {
    return HomePageLayout(
      title: "e-Meal",
      menu: [
        HomeMenuModel("ホーム", Icons.home_filled),
        HomeMenuModel("作り置き管理", Icons.inventory),
        HomeMenuModel("食事管理", Icons.lunch_dining),
        HomeMenuModel("プロフィール", Icons.person)
      ],
      screens: <Widget>[
        const HomeComponent(),
        MealPrepsComponent(pageState: pageState),
        LunchView(pageState: pageState),
        const ProfileComponent()
      ],
      actions: [
        IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
        IconButton(onPressed: togglePageState, icon: Icon(icon())),
        IconButton(onPressed: togglePageState, icon: Icon(icon())),
        IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
      ],
    );
  }

  void togglePageState() {
    setState(() {
      if (pageState == PageState.post) {
        pageState = PageState.list;
      } else {
        pageState = PageState.post;
      }
    });
  }

  IconData icon() {
    if (pageState == PageState.list) {
      return Icons.post_add;
    } else {
      return Icons.list;
    }
  }

  void logout() {}
}
