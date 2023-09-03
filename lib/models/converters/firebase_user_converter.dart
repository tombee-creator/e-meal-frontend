import 'dart:convert';

import 'package:emeal_app/models/firebase_user.dart';
import 'package:json_annotation/json_annotation.dart';

class FirebaseUserConverter implements JsonConverter<FirebaseUser?, String?> {
  const FirebaseUserConverter();

  @override
  FirebaseUser? fromJson(String? text) =>
      FirebaseUser.fromJson(json.decode(text ?? "") as Map<String, dynamic>);

  @override
  String? toJson(FirebaseUser? object) => object?.id;
}
