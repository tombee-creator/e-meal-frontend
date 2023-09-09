import 'package:flutter/material.dart';
import 'package:emeal_app/models/home_menu_model.dart';
import 'package:emeal_app/views/home/buttons/home_button_list.dart';

class HomePageLayout extends StatefulWidget {
  final String title;
  final List<Widget> screens;
  final List<HomeMenuModel> menu;
  final List<Widget> actions;
  final List<PreferredSizeWidget?> bottoms;
  final int tabCount;

  const HomePageLayout(
      {super.key,
      required this.title,
      required this.menu,
      required this.screens,
      required this.actions,
      required this.bottoms,
      required this.tabCount});

  @override
  State<StatefulWidget> createState() => HomePageLayoutState();
}

class HomePageLayoutState extends State<HomePageLayout> {
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: widget.tabCount,
        child: Scaffold(
          appBar: AppBar(
              title: Text(widget.title),
              actions: [widget.actions[current]],
              bottom: widget.bottoms[current]),
          body: SafeArea(child: widget.screens[current]),
          bottomNavigationBar: HomeButtonList(
            menu: widget.menu,
            selected: current,
            onTap: onTap,
          ),
          resizeToAvoidBottomInset: false,
        ));
  }

  void onTap(selected) {
    setState(() {
      current = selected;
    });
  }
}
