import 'package:emeal_app/views/home/components/meal_preps/meal_prep_list_component.dart';
import 'package:flutter/material.dart';

class MealPrepsComponent extends StatefulWidget {
  const MealPrepsComponent({super.key});

  @override
  State<StatefulWidget> createState() => MealPrepsComponentState();
}

class MealPrepsComponentState extends State<MealPrepsComponent> {
  @override
  Widget build(BuildContext context) {
    return const MealPrepListComponent();
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
