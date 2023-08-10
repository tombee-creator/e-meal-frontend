import 'package:flutter/material.dart';
import 'package:frontend/services/authentication.dart';
import 'package:frontend/services/database.dart';
import 'package:frontend/views/common/avatar.dart';
import 'package:frontend/views/common/recipe/recipe_list_view.dart';
import 'package:frontend/views/common/icon_size.dart';
import 'package:frontend/views/profile/top_profile_item_component.dart';

class ProfileComponent extends StatefulWidget {
  const ProfileComponent({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileComponentState();
}

class _ProfileComponentState extends State<ProfileComponent> {
  @override
  Widget build(BuildContext context) {
    final user = Authentication().currentUser;
    final userEmail = user.email;
    final userPhotoUrl = user.photoURL;

    if (userEmail == null) {
      throw UnsupportedError("ユーザ認証されていません");
    }

    final list = <Widget>[];
    list.add(Padding(
        padding: const EdgeInsets.all(10.0),
        child: createTopRowProfile(context, userEmail, userPhotoUrl)));
    list.add(
      const TabBar(tabs: <Widget>[
        Tab(icon: Icon(Icons.dinner_dining)),
        Tab(icon: Icon(Icons.money))
      ]),
    );
    list.add(Expanded(
        child: TabBarView(children: [
      RecipeListView(future: Database().getDishes()),
      RecipeListView(future: Database().getDishes()),
    ])));

    return DefaultTabController(
        length: 2,
        child: Column(
          children: list,
        ));
  }

  Widget createTopRowProfile(
      BuildContext context, String userEmail, String? userPhotoUrl) {
    final items = <Widget>[];
    items.add(Stack(
      children: [
        Avatar().generate(userPhotoUrl, size: IconSize.large),
        const Positioned(
            right: 0,
            bottom: 0,
            child: Icon(Icons.add_circle_outline_outlined)),
      ],
    ));
    items.add(const Spacer());
    items.add(const IntrinsicWidth(
      child: Row(
        children: [
          TopProfileItemComponent(icon: Icons.cookie, label: "レシピ", value: 100),
          TopProfileItemComponent(icon: Icons.person, label: "フォロー", value: 3),
          TopProfileItemComponent(
              icon: Icons.person_outlined, label: "フォロワー", value: 5)
        ],
      ),
    ));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: items,
    );
  }
}
