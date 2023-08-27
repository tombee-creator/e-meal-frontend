import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CRUDApi<T> {
  Future<List<T>> list(
      {Query<Map<String, dynamic>> Function(
              CollectionReference<Map<String, dynamic>>)?
          query});
  Future<T?> get(String id);
  Future<T?> post(Map<String, dynamic> Function(String id) builder);
  Future<T?> put(
      String id, T item, Map<String, dynamic> Function(T item) builder);
}
