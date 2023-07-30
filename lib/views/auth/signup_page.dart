import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:frontend/views/auth/authenticate_input_widget.dart';

import '../../resource/resource.dart';

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
        behavior: LoginPageBehavior(),
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
                                                ..onTap = forgotPasswordAction,
                                            ),
                                          )
                                        ],
                                      )),
                                  SizedBox(height: size.width * .3),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: loginAction,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        bottom: size.width * .05,
                                      ),
                                      height: size.width / 8,
                                      width: size.width / 1.25,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(.1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Text(
                                        'Sing-In',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
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

  void loginAction() {}

  void forgotPasswordAction() {}
}

class LoginPageBehavior extends ScrollBehavior {}
