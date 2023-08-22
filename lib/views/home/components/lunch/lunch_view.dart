import 'package:emeal_app/views/home/components/lunch/lunch_post_view.dart';
import 'package:emeal_app/views/pages/home_page.dart';
import 'package:flutter/material.dart';

class LunchView extends StatefulWidget {
  final PageState pageState;

  const LunchView({super.key, required this.pageState});

  @override
  State<StatefulWidget> createState() => LunchViewState();
}

class LunchViewState extends State<LunchView> {
  @override
  Widget build(BuildContext context) {
    if (widget.pageState == PageState.post) {
      return const Center(child: Text("リスト"));
    } else {
      return const LunchPostView();
    }
  }
}
