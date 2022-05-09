import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import './src/domain/entities/site_setting/site_setting.dart';
import './src/app/main/main_view.dart';
import 'package:flutter/material.dart';

// import 'src/data/utils/dio/api.dart';
// import 'src/data/utils/dio/dio_utils.dart';

void main() {
  // 測試用
  // about();
  // login();

  runApp(const MyApp());
}

// void about() async {
//   try {
//     final res = await HttpUtils.instance.get(Api.about);
//     debugPrint('title ====> ${res.data["title"]}');
//     debugPrint('body ====> ${res.data["body"]}');
//   } catch (e) {
//     debugPrint('異常:$e');
//   }
// }

// void login() async {
//   try {
//     final res = await HttpUtils.instance.post(Api.login,
//         params: {"mobile": "0999999999", "password": "Aa123456"});

//     if (res.isSuccess) {
//       var token = res.data["access_token"];

//       debugPrint('access_token ====> $token');
//     } else {
//       debugPrint('error ====> ${res.message}');
//     }
//   } catch (e) {
//     debugPrint('異常:$e');
//   }
// }
  // final Color memberBackground;
  // mem_back_color
  // icon
  // final Color borderTitleBackground;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static ThemeData _buildMyPlusTheme(SiteSetting setting) {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: setting.layout.sidebar.logoBackground,
        foregroundColor: setting.layout.sidebar.logoTint,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: setting.layout.sidebar.footerTint,
        unselectedItemColor: setting.layout.sidebar.footerTint.withAlpha(192),
        backgroundColor: setting.layout.sidebar.footerBackground,
      ),
      primaryColor: setting.layout.setting.theme,
      focusColor: setting.layout.setting.focus,
      textTheme: _buildMyPlusTextTheme(base.textTheme, setting),
      textSelectionTheme: const TextSelectionThemeData(
        selectionColor: Colors.lightGreen
      ),
    );
  }

  static TextTheme _buildMyPlusTextTheme(TextTheme base, SiteSetting setting) {
    return base.copyWith(
      headline5: base.headline5!.copyWith(
        fontWeight: FontWeight.w500,
      ),
      headline6: base.headline6!.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
        color: setting.layout.setting.title,
      ),
      caption: base.caption!.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 14.0,
        color: setting.layout.setting.title,
      ),
      bodyText1: base.bodyText1!.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
      ),
    ).apply(
      fontFamily: 'PingFang TC',
      // bodyColor: setting.layout.setting.title,
      // displayColor: setting.layout.setting.title,
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterCleanArchitecture.debugModeOn();
    return ValueListenableBuilder<SiteSetting>(
      valueListenable: SiteSetting.notifier,
      builder: (_, setting, __) {
        return MaterialApp(
          theme: _buildMyPlusTheme(setting),
          darkTheme: ThemeData.dark(),
          home: MainPage(title: '買+'),
        );
      },
    );
  }
}
