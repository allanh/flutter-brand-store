import 'package:flutter/material.dart';

// TODO(error): Navigator測試用錯誤頁, 之後需改寫
class ErrorPage extends StatelessWidget {
  final Exception? error;
  String? message;

  ErrorPage({Key? key, this.error, this.message}) : super(key: key) {
    if (error != null) {
      message = error.toString();
    } else {
      message ??= 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(message!)));
  }
}
