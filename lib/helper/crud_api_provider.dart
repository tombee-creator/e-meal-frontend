import 'package:frontend/helper/crud_api.dart';

class CrudAPIProvider {
  CRUDApi<T> provider<T>(CRUDApi<T> api) => api;
}
