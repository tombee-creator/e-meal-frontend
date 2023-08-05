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
    try {
      await FirebaseAuth.instance.currentUser?.reload();
    } catch (_) {}
  }

  bool get isAuthenticated => FirebaseAuth.instance.currentUser != null;

  Future<UserCredential> login(String email, String password) async {
    return await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> signup(
      String email, String password1, String password2) async {
    if (password1 == password2) {
      throw UnsupportedError("パスワードが一致していません");
    }
    return await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password1);
  }

  Future<void> signout() async {
    return FirebaseAuth.instance.signOut();
  }
}
