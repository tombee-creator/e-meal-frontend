import 'package:flutter/material.dart';
import 'package:frontend/views/home/home_page_layout.dart';

import '../../models/HomeMenuModel.dart';

class HomePage extends StatelessWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return HomePageLayout(
      title: "つみたべ",
      menu: [
        HomeMenuModel("ホーム", Icons.home_filled),
        HomeMenuModel("設定", Icons.settings)
      ],
      screens: <Widget>[
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'クリック数: ',
              ),
              Text(
                '1',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'クリック数: ',
              ),
              Text(
                '0',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        )
      ],
    );
  }
}
