import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:emeal_app/services/authentication.dart';
import 'package:emeal_app/settings/settings_info.dart';

class EMealHttpClient {
  EMealHttpClient? _instance;

  factory() => _instance ??= EMealHttpClient();

  Future<List<dynamic>> getRecipeData(File image) async {
    final backendUrl = SettingsInfo().backendUrl;
    final base64Image = base64Encode(await image.readAsBytes());
    final uri = Uri.parse("${backendUrl}convert-recipe/");
    final token = await Authentication().getToken();
    if (token == null) {
      throw UnimplementedError();
    }
    final result = await http.post(uri,
        headers: {"Authorization": await Authentication().getToken() ?? ""},
        body: {"receipt": base64Image});
    if (result.statusCode == 200) {
      return json.decode(utf8.decode(result.bodyBytes));
    } else {
      throw UnsupportedError(result.body);
    }
  }
}
