import 'package:flutter/material.dart';
import 'package:frontend/services/authentication.dart';
import 'package:frontend/views/common/avatar.dart';
import 'package:frontend/views/common/icon_size.dart';

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
    final userPhoto = user.photoURL;

    if (userEmail == null) {
      throw UnsupportedError("ユーザ認証されていません");
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Center(child: Avatar().generate(userPhoto, size: IconSize.large)),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [Text(userEmail)],
            ),
          )
        ],
      ),
    );
  }
}
