import 'package:flutter/material.dart';

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

  static Color get strawberry => const Color.fromRGBO(242, 63, 68, 1);
  static Color get comingSoon => const Color.fromRGBO(114, 0, 255, 1);
  static Color get reddishOrange => const Color.fromRGBO(255, 83, 20, 1);
  static Color get strongPink => const Color.fromRGBO(255, 14, 137, 1);
  static Color get whiteTwo => const Color.fromRGBO(242, 242, 242, 1);
  static Color get pumpkinOrange => const Color.fromRGBO(255, 133, 0, 1);
  static Color get disabledBorder => const Color.fromRGBO(204, 204, 204, 1);
  static Color get brownGreyTwo => const Color.fromRGBO(180, 180, 180, 1);

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
