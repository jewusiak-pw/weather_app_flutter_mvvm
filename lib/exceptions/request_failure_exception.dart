import 'package:flutter/material.dart';
import 'package:weather_app_flutter_mvvm/main.dart';

class RequestFailureException implements Exception {
  late String _message;

  RequestFailureException(this._message) : super() {
    showAlertDialog(GlobalKeyHelper.navigatorKey.currentContext!);
  }

  String get message => _message;

  @override
  String toString() {
    return 'RequestFailureException{_message: $_message}';
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () => Navigator.pop(context),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Request failure"),
      content: Text(_message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
