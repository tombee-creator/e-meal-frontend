import 'package:emeal_app/views/home/components/meal_preps/meal_prep_list_component.dart';
import 'package:emeal_app/views/home/components/meal_preps/meal_prep_post_component.dart';
import 'package:emeal_app/views/pages/home_page.dart';
import 'package:flutter/material.dart';

class MealPrepsComponent extends StatefulWidget {
  final PageState pageState;

  const MealPrepsComponent({super.key, required this.pageState});

  @override
  State<StatefulWidget> createState() => MealPrepsComponentState();
}

class MealPrepsComponentState extends State<MealPrepsComponent> {
  @override
  Widget build(BuildContext context) {
    if (widget.pageState == PageState.list) {
      return const MealPrepPostComponent();
    } else {
      return const MealPrepListComponent();
    }
  }

  // void toggle() {
  //   setState(() {
  //     if (pageState == PageState.post) {
  //       pageState = PageState.list;
  //     } else {
  //       pageState = PageState.post;
  //     }
  //   });
  // }

  // IconData icon() {
  //   if (pageState == PageState.list) {
  //     return Icons.post_add;
  //   } else {
  //     return Icons.list;
  //   }
  // }
}
