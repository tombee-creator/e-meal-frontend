import 'package:emeal_app/models/recipe.dart';
import 'package:emeal_app/services/authentication.dart';
import 'package:emeal_app/services/database.dart';
import 'package:emeal_app/services/firestore_crud_api.dart';
import 'package:emeal_app/views/home/components/lunch/lunch_list_view.dart';
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
    final api = Database()
        .provider<Recipe>(FirestoreCRUDApi("recipes", Recipe.fromJson));
    return Stack(
      children: [
        FutureBuilder(
            future: api.list(
                query: (ref) => ref
                    .orderBy("created", descending: true)
                    .where("user", isEqualTo: Authentication().currentUser.uid)
                    .limit(15)),
            builder: ((context, snapshot) {
              final data = snapshot.data;
              if (data == null) {
                return const Center(
                  child: Text("データを取得中です"),
                );
              }
              return LunchListView(recipes: data);
            })),
        Positioned(
            right: 20.0,
            bottom: 20.0,
            child: FloatingActionButton(
              child: const Icon(Icons.post_add),
              onPressed: () {
                Navigator.of(context).pushNamed("/recipes");
              },
            ))
      ],
    );
  }
}
