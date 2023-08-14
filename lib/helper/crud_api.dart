abstract class CRUDApi<T> {
  Future<List<T>> list();
  Future<T?> get(String id);
  Future<void> post(Map<String, dynamic> Function(String id) builder);
}
