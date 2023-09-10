// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdInfo _$AdInfoFromJson(Map<String, dynamic> json) => AdInfo(
      googleAppId: json['androidAppId'] as String,
      iOSAppId: json['iOSAppId'] as String,
    );

Map<String, dynamic> _$AdInfoToJson(AdInfo instance) => <String, dynamic>{
      'androidAppId': instance.googleAppId,
      'iOSAppId': instance.iOSAppId,
    };
