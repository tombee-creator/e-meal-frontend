import 'package:tsumitabe_app/helper/crud_api_provider.dart';

class Database extends CrudAPIProvider {
  Database? _instance;

  factory() => _instance ??= Database();
}
