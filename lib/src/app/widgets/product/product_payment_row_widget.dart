import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/product/payment.dart';
import '../../../extension/num_extension.dart';

/// 付款列
class ProductPaymentRowWidget extends StatelessWidget {
  const ProductPaymentRowWidget(
      {Key? key, required this.price, required this.info})
      : super(key: key);

  final int price;
  final Payment info;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
        style: Theme.of(context)
                .textTheme
                .caption
                ?.copyWith(fontSize: 14.0, color: UdiColors.greyishBrown) ??
            const TextStyle(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // 信用卡
          if (info.credit?.isEnable == true)
            SizedBox(
              height: 20,
              child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: info.credit?.isStaging == true &&
                          info.credit?.stagingInfo?.isNotEmpty == true
                      ? getDefaultStage(context)
                      : const Text('信用卡')),
            ),

          // ATM
          if (info.atm?.isEnable == true)
            Container(
              padding: const EdgeInsets.only(top: 4),
              height: 20,
              child: const Text('ATM'),
            ),
        ]));
  }

  /// 取得信用卡第一個分期資訊
  Widget getDefaultStage(BuildContext context) {
    TextStyle? _strawberryStyle = Theme.of(context)
        .textTheme
        .caption
        ?.copyWith(fontSize: 14.0, color: UdiColors.strawberry);

    StagingInfo stagingInfo = info.credit!.stagingInfo!.first;

    return Text.rich(TextSpan(children: [
      const TextSpan(text: "信用卡，"),
      TextSpan(text: stagingInfo.stage?.toString(), style: _strawberryStyle),
      const TextSpan(text: " 期 "),
      if (stagingInfo.isInterest == true)
        TextSpan(text: stagingInfo.fee?.toString(), style: _strawberryStyle),
      if (stagingInfo.isInterest == true) const TextSpan(text: " 利率"),
      const TextSpan(text: "，每期 "),
      TextSpan(
          text: stagingInfo.calculateMonthlyPayment(price).toDollarString(),
          style: _strawberryStyle),
    ]));
  }
}
