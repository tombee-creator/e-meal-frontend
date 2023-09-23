import 'package:flutter/material.dart';

class AlertView {
  static final AlertView _instance = AlertView._internal();
  factory AlertView() => _instance;

  AlertView._internal();

  Future<bool> show(BuildContext context,
      {String title = "確認", String body = ""}) async {
    return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) =>
            AlertDialog(title: Text(title), content: Text(body), actions: [
              TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.pop(context, true);
                  }),
              TextButton(
                  child: const Text("Cancel"),
                  onPressed: () {
                    Navigator.pop(context, false);
                  })
            ]));
  }
}
