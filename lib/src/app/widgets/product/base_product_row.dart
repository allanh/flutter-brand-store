import 'package:brandstores/src/app/utils/screen_config.dart';
import 'package:flutter/material.dart';

import '../../../device/utils/my_plus_colors.dart';

/// 促銷活動
class BaseProductRow extends StatelessWidget {
  const BaseProductRow(
      {Key? key, required this.title, required this.view, this.onMoreTap})
      : super(key: key);

  final String title;
  final Widget view;

  /// The callback that is called when the more icon is tapped.
  final VoidCallback? onMoreTap;

  @override
  Widget build(BuildContext context) => Container(
      margin: const EdgeInsets.only(top: 8),
      //padding: const EdgeInsets.only(left: 12),
      width: SizeConfig.screenWidth,
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 標題
          Container(
              width: 70,
              padding: const EdgeInsets.only(left: 12, top: 12),
              child: Text(title,
                  //textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(fontSize: 14.0, color: UdiColors.brownGrey))),
          // 內容
          Container(
            width: SizeConfig.screenWidth - ((onMoreTap != null) ? 110 : 90),
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: view,
          ),
          // 更多按鈕
          if (onMoreTap != null)
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
                onTap: () => onMoreTap!()),
        ],
      ));
}
