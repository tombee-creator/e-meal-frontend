import 'package:emeal_app/views/home/components/lunch/lunch_post_view.dart';
import 'package:emeal_app/views/pages/home_page.dart';
import 'package:flutter/material.dart';

class LunchView extends StatelessWidget {
  final PageState pageState;

  const LunchView({super.key, required this.pageState});

  @override
  Widget build(BuildContext context) {
    if (pageState == PageState.post) {
      return Center(child: Text("リスト"));
    } else {
      return const LunchPostView();
    }
  }
}
