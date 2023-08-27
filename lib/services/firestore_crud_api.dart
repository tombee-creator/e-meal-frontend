import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emeal_app/helper/crud_api.dart';

class FirestoreCRUDApi<T> implements CRUDApi<T> {
  final String collection;
  final T Function(Map<String, dynamic>) converter;

  FirestoreCRUDApi(this.collection, this.converter);

  @override
  Future<List<T>> list(
      {Query<Map<String, dynamic>> Function(
              CollectionReference<Map<String, dynamic>>)?
          query}) async {
    final ref = FirebaseFirestore.instance.collection(collection);
    final queriedList = query != null ? query(ref) : ref;
    final snapshot = await queriedList.get();
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
  Future<T?> post(Map<String, dynamic> Function(String id) builder) async {
    final document =
        await FirebaseFirestore.instance.collection(collection).add({});
    final recipe = builder(document.id);
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(document.id)
        .set(recipe);
    return await get(document.id);
  }

  @override
  Future<T?> put(
      String id, T item, Map<String, dynamic> Function(T item) builder) async {
    final itemJson = builder(item);
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(id)
        .set(itemJson);
    return await get(id);
  }
}
