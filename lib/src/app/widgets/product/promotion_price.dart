import 'package:flutter/material.dart';

import '../../../device/utils/my_plus_colors.dart';
import '../../utils/constants.dart';

/// App 獨享價列
class PromotionPriceView extends StatelessWidget {
  const PromotionPriceView({Key? key, required this.promotionPrice})
      : super(key: key);

  final int promotionPrice;

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      Container(
          height: 24,
          decoration: BoxDecoration(
              border: Border.all(color: UdiColors.white2),
              borderRadius: BorderRadius.circular(4.0),
              color: Colors.white),
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Wrap(children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    Theme.of(context).primaryColor, BlendMode.modulate),
                child: Image.asset('assets/images/icon_for_all_share.png'),
              ),
            ),
            const SizedBox(width: 5),
            Text('APP下單再減\$${numberFormat.format(promotionPrice)}',
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: 14.0,
                    ))
          ])),
    ]);
  }
}
