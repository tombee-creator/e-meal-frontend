import 'package:emeal_app/helper/crud_api.dart';

class CrudAPIProvider {
  CRUDApi<T> provider<T>(CRUDApi<T> api) => api;
}
