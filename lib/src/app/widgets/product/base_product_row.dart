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
      padding: const EdgeInsets.only(left: 12),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 標題
          Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(title,
                  //textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(fontSize: 14.0, color: UdiColors.brownGrey))),
          // 內容
          Container(
            width: MediaQuery.of(context).size.width -
                ((onMoreTap != null) ? 130 : 90),
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: view,
          ),
          // 更多按鈕
          if (onMoreTap != null)
            GestureDetector(
                child: SizedBox(
                  width: 44,
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
