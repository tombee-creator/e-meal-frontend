import 'package:flutter/material.dart';
import 'package:emeal_app/models/home_menu_model.dart';

class HomeButtonList extends StatelessWidget {
  final List<HomeMenuModel> menu;
  final int selected;
  final void Function(int) onTap;

  const HomeButtonList(
      {super.key,
      required this.menu,
      required this.selected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final items = menu
        .map((item) =>
            BottomNavigationBarItem(icon: Icon(item.icon), label: item.label))
        .toList();
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: items,
      currentIndex: selected,
      onTap: onTap,
    );
  }
}
