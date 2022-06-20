import 'package:brandstores/src/app/utils/screen_config.dart';
import 'package:flutter/material.dart';

import '../../../device/utils/my_plus_colors.dart';

/// 促銷活動
class BaseProductRow extends StatelessWidget {
  const BaseProductRow(
      {Key? key,
      required this.title,
      required this.view,
      this.moreTapped,
      this.marginTop})
      : super(key: key);

  final String title;
  final Widget view;
  final double? marginTop;

  /// The callback that is called when the more icon is tapped.
  final VoidCallback? moreTapped;

  @override
  Widget build(BuildContext context) => Container(
      margin: EdgeInsets.only(top: marginTop ?? 0),
      //padding: const EdgeInsets.only(left: 12),
      width: SizeConfig.screenWidth,
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 標題
          Container(
              width: 70,
              padding: const EdgeInsets.only(left: 12, top: 12, bottom: 12),
              child: Text(title,
                  //textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(fontSize: 14.0, color: UdiColors.brownGrey))),
          // 內容
          Container(
            width: SizeConfig.screenWidth - ((moreTapped != null) ? 110 : 90),
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: view,
          ),
          // 更多按鈕
          if (moreTapped != null)
            GestureDetector(
                child: SizedBox(
                  width: 40,
                  height: 44,
                  child: Image.asset(
                    'assets/images/icon_more.png',
                    width: 20,
                    height: 20,
                  ),
                ),
                onTap: () => moreTapped!()),
        ],
      ));
}
