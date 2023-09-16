import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';

part 'firebase_user.g.dart';

@JsonSerializable()
class FirebaseUser {
  final String username;
  final String email;

  FirebaseUser({required this.username, required this.email});
  static FirebaseUser from(User user) =>
      FirebaseUser(username: user.uid, email: user.email ?? "");

  factory FirebaseUser.fromJson(Map<String, dynamic> json) =>
      _$FirebaseUserFromJson(json);

  Map<String, dynamic> toJson() => _$FirebaseUserToJson(this);
}
