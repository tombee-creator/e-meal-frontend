import 'package:frontend/helper/crud_api_provider.dart';

class Database extends CrudAPIProvider {
  Database? _instance;

  factory() => _instance ??= Database();
}
