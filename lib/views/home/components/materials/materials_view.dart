import 'package:emeal_app/views/home/components/materials/material_post_view.dart';
import 'package:emeal_app/views/home/components/materials/materials_list_view.dart';
import 'package:emeal_app/views/pages/home_page.dart';
import 'package:flutter/material.dart';

class MaterialsView extends StatelessWidget {
  final PageState pageState;

  const MaterialsView({super.key, required this.pageState});

  @override
  Widget build(BuildContext context) {
    if (pageState == PageState.post) {
      return const MaterialsListView();
    } else {
      return const MaterialPostView();
    }
  }
}
