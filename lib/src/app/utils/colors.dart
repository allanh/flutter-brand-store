import 'package:flutter/material.dart';

class MyPlusColor {
  static Color get strawberry => const Color.fromRGBO(242, 63, 68, 1);
  static Color get comingSoon => const Color.fromRGBO(114, 0, 255, 1);
  static Color get reddishOrange => const Color.fromRGBO(255, 83, 20, 1);
  static Color get strongPink => const Color.fromRGBO(255, 14, 137, 1);
  static Color get whiteTwo => const Color.fromRGBO(242, 242, 242, 1);
  static Color get brownGrey => const Color.fromRGBO(127, 127, 127, 1);

  /// 限時採購漸層色
  static LinearGradient get flashSaleGradient => LinearGradient(
        colors: [strongPink, reddishOrange],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );

  /// 即將開始漸層色
  static LinearGradient get comingSoonGradient => LinearGradient(
        colors: [const Color.fromRGBO(0, 145, 255, 1), comingSoon],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );
}
