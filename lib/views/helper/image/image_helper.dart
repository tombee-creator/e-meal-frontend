import 'package:flutter/material.dart';
import 'package:emeal_app/helper/cache_provider.dart';

class ImageHelper {
  static Widget image(String url) => FutureBuilder(
      future: _getImage(url),
      builder: ((context, snapshot) {
        final data = snapshot.data;
        if (data == null) {
          return Container();
        }
        return data;
      }));

  static Future<Image> _getImage(String url) async {
    if (!await CacheProvider().exists(url)) {
      await CacheProvider().write(url);
    }
    final file = await CacheProvider().read(url);
    return Image.file(file);
  }
}
