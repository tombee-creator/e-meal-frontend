import 'package:flutter/material.dart';
import 'package:frontend/models/home_menu_model.dart';

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
      items: items,
      currentIndex: selected,
      onTap: onTap,
    );
  }
}
