import 'package:emeal_app/models/firebase_user.dart';

class FirebaseUserConverter {
  const FirebaseUserConverter();

  static FirebaseUser fromJson(Map<String, dynamic> data) =>
      FirebaseUser.fromJson(data);

  static String toJson(FirebaseUser object) => object.id;
}
