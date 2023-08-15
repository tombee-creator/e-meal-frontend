import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tsumitabe_app/helper/crud_api.dart';

class FirestoreCRUDApi<T> implements CRUDApi<T> {
  final String collection;
  final T Function(Map<String, dynamic>) converter;

  FirestoreCRUDApi(this.collection, this.converter);

  @override
  Future<List<T>> list() async {
    final snapshot =
        await FirebaseFirestore.instance.collection(collection).get();
    return snapshot.docs.map((item) => converter(item.data())).toList();
  }

  @override
  Future<T?> get(String id) async {
    final document =
        await FirebaseFirestore.instance.collection(collection).doc(id).get();
    if (!document.exists) {
      return null;
    }
    final data = document.data();
    if (data == null) {
      return null;
    }
    return converter(data);
  }

  @override
  Future<void> post(Map<String, dynamic> Function(String id) builder) async {
    final document =
        await FirebaseFirestore.instance.collection(collection).add({});
    final recipe = builder(document.id);
    return await FirebaseFirestore.instance
        .collection(collection)
        .doc(document.id)
        .set(recipe);
  }
}
