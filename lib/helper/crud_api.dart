abstract class CRUDApi<T> {
  Future<List<T>> list({String? query});
  Future<T?> get(String id);
  Future<T?> post(Map<String, dynamic> Function(String id) builder);
  Future<T?> put(
      String id, T item, Map<String, dynamic> Function(T item) builder);
}
