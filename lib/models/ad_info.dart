import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'ad_info.g.dart';

@JsonSerializable()
class AdInfo {
  final String googleAppId;
  final String iOSAppId;

  String get unitId {
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
