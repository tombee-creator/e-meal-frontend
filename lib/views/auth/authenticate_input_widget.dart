import 'package:flutter/material.dart';

class AuthenticateInputWidget extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final bool isEmail;
  final bool isPassword;
  final void Function(String) onChanged;

  const AuthenticateInputWidget(
      {super.key,
      required this.hintText,
      required this.icon,
      required this.isEmail,
      required this.isPassword,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        height: size.width / 8,
        width: size.width / 1.25,
        alignment: Alignment.center,
        padding: EdgeInsets.only(right: size.width / 30),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextField(
          style: TextStyle(
            color: Colors.white.withOpacity(.9),
          ),
          obscureText: isPassword,
          keyboardType:
              isEmail ? TextInputType.emailAddress : TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: Colors.white.withOpacity(.8),
            ),
            border: InputBorder.none,
            hintMaxLines: 1,
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(.5),
            ),
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
