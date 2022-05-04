import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

// import './src/app/pages/home/home_view.dart';
import './src/app/main/main_view.dart';
import 'package:flutter/material.dart';

import 'src/data/utils/dio/api.dart';
import 'src/data/utils/dio/dio_utils.dart';

void main() {
  // 測試用
  about();
  login();

  runApp(const MyApp());
}

void about() async {
  try {
    final res = await HttpUtils.instance.get(Api.about);
    debugPrint('title ====> ${res.data["title"]}');
    debugPrint('body ====> ${res.data["body"]}');
  } catch (e) {
    debugPrint('異常:$e');
  }
}

void login() async {
  try {
    final res = await HttpUtils.instance.post(Api.login,
        params: {"mobile": "0999999999", "password": "Aa123456"});

    if (res.isSuccess) {
      var token = res.data["access_token"];

      debugPrint('access_token ====> $token');
    } else {
      debugPrint('error ====> ${res.message}');
    }
  } catch (e) {
    debugPrint('異常:$e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterCleanArchitecture.debugModeOn();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MainPage(title: 'Flutter Demo Home Page'),
    );
  }
}
