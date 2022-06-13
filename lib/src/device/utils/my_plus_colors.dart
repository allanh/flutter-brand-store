import 'package:flutter/material.dart';

/* 
    Hex Opacity Values
    100% — FF  95% — F2  90% — E6  85% — D9  80% — CC
    75% — BF  70% — B3  65% — A6  60% — 99  55% — 8C
    50% — 80  45% — 73  40% — 66  35% — 59  30% — 4D
    25% — 40  20% — 33  15% — 26  10% — 1A  5% — 0D
    0% — 00
  */
extension UdiColors on Colors {
  static const Color white = Color(0xfffbfbfb);
  static const Color white2 = Color(0xfff2f2f2);
  static const Color veryLightGrey2 = Color(0xffe5e5e5);
  static const Color greyishBrown = Color(0xff4c4c4c);

  static const Color brownGrey2 = Color(0xffb4b4b4);
  static const Color green = Color(0xff1ab643);

  static const Color brownGrey = Color(0xff7c7c7c);

  // 全站規範 - Neutral Color
  static const Color normalText = Color(0xff4c4c4c);
  static const Color secondaryText = Color(0xff7f7f7f);
  static const Color normalIcon = Color(0xff7f7f7f);
  static const Color hintText = Color(0xffb4b4b4);
  static const Color disabledText = Color(0xffb4b4b4);
  static const Color border = Color(0xffcccccc);
  static const Color divider = Color(0xffe5e5e5);

  // 全站規範 - Semantic Color
  static const Color danger = Color(0xfff23f44);

  // 全站規範 - Input state
  static const Color defaultBorder = Color(0xffe5e5e5);
  static const Color focusedBorder = Color(0xff4c4c4c);

  static Color get strawberry => const Color(0xfff23f44);
  static Color get comingSoon => const Color(0xff7200ff);
  static Color get reddishOrange => const Color(0xffff5314);
  static Color get strongPink => const Color(0xffff0e89);
  static Color get pumpkinOrange => const Color(0xffff8500);
  static Color get pinkishGrey => const Color(0xffcccccc);

  /// 限時採購漸層色
  static LinearGradient get flashSaleGradient => LinearGradient(
        colors: [strongPink, reddishOrange],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );

  /// 即將開始漸層色
  static LinearGradient get comingSoonGradient => LinearGradient(
        colors: [const Color(0xff0091ff), comingSoon],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );
}
