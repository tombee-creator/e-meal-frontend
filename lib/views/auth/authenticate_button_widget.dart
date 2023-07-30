import 'package:flutter/material.dart';

class AuthenticateButtonWidget extends StatelessWidget {
  final String text;
  final Color color;
  final void Function() onTap;

  const AuthenticateButtonWidget(
      {super.key,
      required this.text,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(
          bottom: size.width * .05,
        ),
        height: size.width / 8,
        width: size.width / 1.25,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color.withOpacity(.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
