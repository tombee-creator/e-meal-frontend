import 'package:tsumitabe_app/helper/crud_api.dart';

class CrudAPIProvider {
  CRUDApi<T> provider<T>(CRUDApi<T> api) => api;
}
