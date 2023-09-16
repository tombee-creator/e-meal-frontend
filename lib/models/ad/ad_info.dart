import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ad_info.g.dart';

@JsonSerializable()
class AdInfo {
  /// Google Ad Mobのテスト用Ad ID
  static const String testAdId = "ca-app-pub-3940256099942544/6300978111";

  final String googleAppId;
  final String iOSAppId;

  String get unitId {
    if (kDebugMode || kProfileMode) {
      return testAdId;
    }
    if (Platform.isAndroid) {
      return googleAppId;
    } else if (Platform.isIOS) {
      return iOSAppId;
    } else {
      throw UnimplementedError("お使いのプラットフォームでは広告が表示されません");
    }
  }

  AdInfo({required this.googleAppId, required this.iOSAppId});

  factory AdInfo.fromJson(Map<String, dynamic> json) => _$AdInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AdInfoToJson(this);
}
