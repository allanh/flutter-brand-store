import 'package:flutter/material.dart';

import '../../../device/utils/my_plus_colors.dart';

/// 促銷活動
class BaseProductRow extends StatelessWidget {
  const BaseProductRow(
      {Key? key, required this.title, required this.child, this.onMoreClicked})
      : super(key: key);

  final String title;
  final Widget child;

  /// The callback that is called when the countdown timer is ended.
  final VoidCallback? onMoreClicked;

  @override
  Widget build(BuildContext context) => Container(
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          Text(title,
              textAlign: TextAlign.justify,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.copyWith(color: UdiColors.brownGrey))
        ],
      ));
}
