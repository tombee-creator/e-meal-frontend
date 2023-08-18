import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:path_provider/path_provider.dart';

class CacheProvider {
  CacheProvider? _provider;
  factory() => _provider ??= CacheProvider();

  Future<String> pathFrom(String url) async {
    final protocols = RegExp(r'^[a-zA-Z]+://');
    final query = RegExp(r'\?.+$');
    final directory = await getApplicationDocumentsDirectory();
    final urlPath = url.replaceAll(protocols, "").replaceAll(query, "");
    final path = '${directory.path}/$urlPath';
    return path;
  }

  Future<bool> exists(String url) async => File(await pathFrom(url)).exists();

  Future<File> read(String url) async => File(await pathFrom(url));

  Future write(String url) async {
    final path = await pathFrom(url);
    final http.Response res = await http.get(Uri.parse(url));
    final file = File(path);
    await file.create(recursive: true);
    await file.writeAsBytes(res.bodyBytes);
  }
}
