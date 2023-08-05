import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/services/authentication.dart';
import 'package:frontend/views/auth/authenticate_input_widget.dart';

import '../../resource/resource.dart';

import 'authenticate_button_widget.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<StatefulWidget> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String email = "";
  String password1 = "";
  String password2 = "";

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
                                          Resource().signupLabel,
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white.withOpacity(.8),
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              Resource().signupHelperMessage,
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
                                            password1 = value;
                                          })),
                                  AuthenticateInputWidget(
                                      icon: Icons.lock_outline,
                                      hintText: 'パスワード（確認）',
                                      isPassword: true,
                                      isEmail: false,
                                      onChanged: (value) => setState(() {
                                            password2 = value;
                                          })),
                                  const Spacer(),
                                  Column(
                                    children: [
                                      AuthenticateButtonWidget(
                                          text: "ユーザ登録",
                                          color: Colors.black,
                                          onTap: signup),
                                      AuthenticateButtonWidget(
                                          text: "ログインへ",
                                          color: Colors.red,
                                          onTap: toLoginPage)
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

  void signup() {
    try {
      Authentication().signup(email, password1, password2).then((_) =>
          Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false));
    } on FirebaseAuthException catch (_) {}
  }

  void toLoginPage() {
    Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
  }
}
