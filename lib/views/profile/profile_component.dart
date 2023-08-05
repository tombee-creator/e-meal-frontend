import 'package:flutter/material.dart';
import 'package:frontend/services/authentication.dart';
import 'package:frontend/views/common/avatar.dart';
import 'package:frontend/views/common/icon_size.dart';
import 'package:frontend/views/profile/profile_text_component.dart';
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

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Center(child: createTopRowProfile(context, userEmail, userPhotoUrl)),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ProfileTextComponent(
                icon: Icons.mail_outline,
                child: Text(
                  userEmail,
                  style: const TextStyle(fontSize: 16.0),
                )),
          ),
        ],
      ),
    );
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TopProfileItemComponent(
              icon: Icons.cookie, label: "レシピ数", value: 100000),
          TopProfileItemComponent(icon: Icons.person, label: "フォロー数", value: 3),
          TopProfileItemComponent(
              icon: Icons.person_outlined, label: "フォロワー数", value: 5)
        ],
      ),
    ));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: items,
    );
  }
}
