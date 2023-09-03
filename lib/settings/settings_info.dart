import 'dart:convert';

import 'package:flutter/services.dart';

class SettingsInfo {
  static const settingsFile = "assets/settings/settings.json";
  static final SettingsInfo _instance = SettingsInfo._internal();

  factory SettingsInfo() => _instance;

  late final String backendUrl;

  Future<void> load() async {
    final data = json.decode(await rootBundle.loadString(settingsFile));
    backendUrl = data["backendUrl"];
  }

  SettingsInfo._internal();
}
