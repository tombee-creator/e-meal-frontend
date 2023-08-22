import 'package:flutter/material.dart';
import 'package:emeal_app/services/authentication.dart';
import 'package:emeal_app/views/common/avatar.dart';
import 'package:emeal_app/views/home/components/cost/food_cost_description_view.dart';
import 'package:emeal_app/views/common/icon_size.dart';
import 'package:emeal_app/views/profile/top_profile_item_component.dart';

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
    list.add(Expanded(
        flex: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            topProfile(context, userEmail, userPhotoUrl),
          ],
        )));
    list.add(const Expanded(
      flex: 3,
      child: FoodCostDescriptionView(),
    ));
    return Column(
      children: list,
    );
  }

  Widget topProfile(
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
    return Column(
      children: items,
    );
  }
}
