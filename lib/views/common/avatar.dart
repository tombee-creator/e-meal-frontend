import 'package:flutter/material.dart';

import 'icon_size.dart';

class Avatar {
  static Avatar? _instance;

  Avatar();

  factory() => _instance ??= Avatar();

  CircleAvatar generate(String? url, {IconSize size = IconSize.small}) {
    if (url == null) {
      return CircleAvatar(
        radius: _getSize(size),
        backgroundColor: Colors.brown.shade800,
        child: const Text('AH'),
      );
    } else {
      return CircleAvatar(
        radius: _getSize(size),
        backgroundImage: NetworkImage(url),
      );
    }
  }

  double _getSize(IconSize size) {
    switch (size) {
      case IconSize.small:
        return 20;
      case IconSize.medium:
        return 30;
      case IconSize.large:
        return 40;
    }
  }
}
