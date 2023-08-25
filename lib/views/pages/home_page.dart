import 'package:emeal_app/generated/l10n.dart';
import 'package:emeal_app/models/home_menu_model.dart';
import 'package:emeal_app/views/home/components/meal-tab/meal_tab_bar_view.dart';
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
  @override
  Widget build(BuildContext context) {
    return HomePageLayout(
      title: "e-Meal",
      tabCount: 3,
      bottoms: const [
        null,
        TabBar(tabs: [
          Tab(
            icon: Icon(Icons.inventory),
          ),
          Tab(
            icon: Icon(Icons.archive),
          ),
          Tab(
            icon: Icon(Icons.lunch_dining),
          ),
        ]),
        null
      ],
      menu: [
        HomeMenuModel(S.of(context).home_menu_button_HOME, Icons.home_filled),
        HomeMenuModel(S.of(context).home_menu_button_COST, Icons.food_bank),
        HomeMenuModel(S.of(context).home_menu_button_PROFILE, Icons.person)
      ],
      screens: const <Widget>[
        HomeComponent(),
        MealTabBarView(),
        ProfileComponent()
      ],
      actions: [
        IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
        IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
        IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
      ],
    );
  }

  void logout() {}
}
