import 'dart:convert';

import 'package:emeal_app/services/authentication.dart';
import 'package:emeal_app/settings/settings_info.dart';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emeal_app/helper/crud_api.dart';

class EMealCrudApi<T> implements CRUDApi<T> {
  final String collection;
  final T Function(Map<String, dynamic>) converter;

  EMealCrudApi(this.collection, this.converter);

  @override
  Future<T?> get(String id) async {
    final backendUrl = SettingsInfo().backendUrl;
    final collection = this.collection;
    final uri = Uri.parse("$backendUrl$collection/$id/");
    final token = await Authentication().getToken();
    if (token == null) {
      throw UnimplementedError();
    }
    final result = await http.get(uri,
        headers: {"Authorization": await Authentication().getToken() ?? ""});
    return converter(
        json.decode(utf8.decode(result.bodyBytes)) as Map<String, dynamic>);
  }

  @override
  Future<List<T>> list(
      {Query<Map<String, dynamic>> Function(
              CollectionReference<Map<String, dynamic>> p1)?
          query}) async {
    final backendUrl = SettingsInfo().backendUrl;
    final collection = this.collection;
    final uri = Uri.parse("$backendUrl$collection/");
    final token = await Authentication().getToken();
    if (token == null) {
      throw UnimplementedError();
    }
    final result = await http.get(uri,
        headers: {"Authorization": await Authentication().getToken() ?? ""});
    return (json.decode(utf8.decode(result.bodyBytes)) as List)
        .map((item) => converter(item))
        .toList();
  }

  @override
  Future<T?> post(Map<String, dynamic> Function(String id) builder) async {
    final backendUrl = SettingsInfo().backendUrl;
    final collection = this.collection;
    final uri = Uri.parse("$backendUrl$collection/");
    final token = await Authentication().getToken();
    if (token == null) {
      throw UnimplementedError();
    }
    final result = await http.post(uri,
        headers: {"Authorization": await Authentication().getToken() ?? ""},
        body: builder(""));
    return converter(json.decode(result.body));
  }

  @override
  Future<T?> put(
      String id, T item, Map<String, dynamic> Function(T item) builder) async {
    final backendUrl = SettingsInfo().backendUrl;
    final collection = this.collection;
    final uri = Uri.parse("$backendUrl$collection/$id/");
    final token = await Authentication().getToken();
    if (token == null) {
      throw UnimplementedError();
    }
    final result = await http.put(uri,
        headers: {"Authorization": await Authentication().getToken() ?? ""},
        body: builder(item));
    return converter(json.decode(result.body));
  }
}
