import 'package:emeal_app/models/home_menu_model.dart';
import 'package:emeal_app/views/home/components/materials/materials_view.dart';
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
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var pageState = PageState.post;

  @override
  Widget build(BuildContext context) {
    return HomePageLayout(
      title: "e-Meal",
      menu: [
        HomeMenuModel("ホーム", Icons.home_filled),
        HomeMenuModel("食材", Icons.food_bank),
        HomeMenuModel("食材", Icons.food_bank),
        HomeMenuModel("食材", Icons.food_bank),
        HomeMenuModel("プロフィール", Icons.person)
      ],
      screens: <Widget>[
        const HomeComponent(),
        MaterialsView(pageState: pageState),
        MealPrepsComponent(pageState: pageState),
        LunchView(pageState: pageState),
        const ProfileComponent()
      ],
      actions: [
        IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
        IconButton(onPressed: toggle, icon: Icon(icon())),
        IconButton(onPressed: toggle, icon: Icon(icon())),
        IconButton(onPressed: toggle, icon: Icon(icon())),
        IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
      ],
    );
  }

  void logout() {}

  void toggle() {
    setState(() {
      if (pageState == PageState.post) {
        pageState = PageState.list;
      } else {
        pageState = PageState.post;
      }
    });
  }

  IconData icon() {
    final state = pageState;
    if (state == PageState.list) {
      return Icons.post_add;
    } else {
      return Icons.list;
    }
  }
}
