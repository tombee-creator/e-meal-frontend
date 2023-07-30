import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/views/auth/authenticate_button_widget.dart';
import 'package:frontend/views/auth/authenticate_input_widget.dart';

import '../../resource/resource.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ScrollConfiguration(
        behavior: const ScrollBehavior(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: Stack(
              children: [
                SizedBox(
                  height: size.height,
                  child: Image.network(
                    Resource().backgroundImageUrl,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      const Expanded(
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 7,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaY: 25, sigmaX: 25),
                            child: SizedBox(
                              width: size.width * .9,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: size.width * .15,
                                      bottom: size.width * .1,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          Resource().loginLabel,
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white.withOpacity(.8),
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              Resource().loginHelperMessage,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white
                                                    .withOpacity(.8),
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                  AuthenticateInputWidget(
                                    icon: Icons.email_outlined,
                                    hintText: 'メールアドレス',
                                    isPassword: false,
                                    isEmail: true,
                                    onChanged: (value) => setState(() {
                                      email = value;
                                    }),
                                  ),
                                  AuthenticateInputWidget(
                                      icon: Icons.lock_outline,
                                      hintText: 'パスワード',
                                      isPassword: true,
                                      isEmail: false,
                                      onChanged: (value) => setState(() {
                                            password = value;
                                          })),
                                  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              text: 'Forgotten password!',
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  HapticFeedback.lightImpact();
                                                  Fluttertoast.showToast(
                                                    msg:
                                                        '${email}\n${password}',
                                                  );
                                                },
                                            ),
                                          )
                                        ],
                                      )),
                                  const Spacer(),
                                  Column(
                                    children: [
                                      AuthenticateButtonWidget(
                                          text: "ログイン",
                                          color: Colors.black,
                                          onTap: login),
                                      AuthenticateButtonWidget(
                                          text: "ユーザ登録へ",
                                          color: Colors.red,
                                          onTap: toSignupPage)
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    try {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((credentials) {
        Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void toSignupPage() {
    Navigator.pushNamedAndRemoveUntil(context, "/signup", (route) => false);
  }
}
