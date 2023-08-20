import 'package:emeal_app/views/home/components/meal_preps/meal_prep_list_component.dart';
import 'package:emeal_app/views/home/components/meal_preps/meal_prep_post_component.dart';
import 'package:emeal_app/views/pages/home_page.dart';
import 'package:flutter/material.dart';

class MealPrepsComponent extends StatefulWidget {
  final PageState pageState;

  const MealPrepsComponent({super.key, required this.pageState});

  @override
  State<StatefulWidget> createState() => _MealPrepsComponentState();

  icon() => IconButton(onPressed: () {}, icon: const Icon(Icons.list));
}

class _MealPrepsComponentState extends State<MealPrepsComponent> {
  @override
  Widget build(BuildContext context) {
    if (widget.pageState == PageState.list) {
      return const MealPrepPostComponent();
    } else {
      return const MealPrepListComponent();
    }
  }
}
