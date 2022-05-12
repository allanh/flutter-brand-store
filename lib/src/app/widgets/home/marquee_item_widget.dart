import 'package:flutter/material.dart';

import '../../../device/utils/my_plus_colors.dart';
import '../../../domain/entities/module/ad_item.dart';

class MarqueeItemWidget extends StatelessWidget {
  const MarqueeItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  final AdItem item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(children: [
          SizedBox(
            width: 20.0,
            height: 20.0,
            child: Text('<',
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: UdiColors.greyishBrown,
                    )),
          ),
          Flexible(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 56.0,
                  height: 24.0,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                  alignment: Alignment.center,
                  child: Text(item.tag ?? '最新',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: Colors.white)),
                ),
                const SizedBox(
                  width: 9.0,
                ),
                Text(
                  item.title ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(color: UdiColors.greyishBrown),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20.0,
            height: 20.0,
            child: Text('>',
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: UdiColors.greyishBrown,
                    )),
          ),
        ]),
      ),
    );
  }
}
