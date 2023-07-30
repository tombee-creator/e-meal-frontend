import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../firebase_options.dart';

/// Firebase Authenticationを使用するためのクラス<br />
/// シングルトンパターンで作成。プログラム中では一度しか生成されない。
class Authentication {
  Authentication? _instance;

  factory() => _instance ??= Authentication();

  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  bool get isAuthenticated => FirebaseAuth.instance.currentUser != null;
}
