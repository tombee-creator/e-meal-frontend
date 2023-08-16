import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CRUDApi<T> {
  Future<List<T>> list(
      {Query<Map<String, dynamic>> Function(
              CollectionReference<Map<String, dynamic>>)?
          query});
  Future<T?> get(String id);
  Future<void> post(Map<String, dynamic> Function(String id) builder);
}
