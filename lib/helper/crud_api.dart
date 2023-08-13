import 'package:firebase_database/firebase_database.dart';

class CRUDApi<T> {
  final String tableName;
  final T Function(Map<String, dynamic>) converter;

  CRUDApi(this.tableName, this.converter);

  List<T> _convertList(
      Object? data, T Function(Map<String, dynamic> json) converter) {
    if (data == null) return [];
    final list = (data as Map<Object?, Object?>).cast<String, dynamic>().values;
    return list
        .map((item) => item as Map<Object?, Object?>)
        .map((item) => item.cast<String, String>())
        .map((item) => converter(item))
        .toList();
  }

  T? _convertItem(
      Object? data, T Function(Map<String, dynamic> json) converter) {
    if (data == null) return null;
    final casted = (data as Map<Object?, Object?>).cast<String, String>();
    return converter(casted);
  }

  Future<List<T>> list() async {
    final ref = FirebaseDatabase.instance.ref(tableName);
    final snapshot = await ref.get();
    final data = snapshot.value;
    if (data == null) {
      return [];
    }
    return _convertList(data, converter);
  }

  Future<T?> get(String id) async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child("recipes/$id").get();
    final data = snapshot.value;
    if (!snapshot.exists) {
      throw UnsupportedError("レシピは見つかりませんでした。");
    }
    return _convertItem(data, converter);
  }

  Future<void> post(Map<String, dynamic> Function(String id) builder) async {
    final ref = FirebaseDatabase.instance.ref(tableName);
    final post = ref.push();
    final key = post.key;
    if (key == null) {
      throw UnsupportedError("要素を追加できませんでした");
    }
    final item = builder(key);
    post.set(item);
  }
}
