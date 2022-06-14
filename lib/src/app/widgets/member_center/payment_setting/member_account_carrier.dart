import 'package:flutter/material.dart';

import '../../../../device/utils/my_plus_colors.dart';
import 'carrier_card.dart';
import 'default_indicator.dart';

/// 會員載具
class MemberAccountCarrier extends StatefulWidget
    implements DefaultCarrierInterface {
  MemberAccountCarrier({
    Key? key,
    required this.isDefault,
  }) : super(key: key);
  @override
  bool isDefault;
  @override
  State<MemberAccountCarrier> createState() => _MemberAccountCarrierState();
}

class _MemberAccountCarrierState extends State<MemberAccountCarrier> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('會員載具   ID:udn12345',
                    style: TextStyle(fontSize: 14.0)),
                SizedBox(
                    height: 24.0,
                    width: 88.0,
                    child: OutlinedButton(
                        onPressed: () {},
                        child: Text('發票歸戶',
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .appBarTheme
                                        .backgroundColor))))
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          const Expanded(
            child: SizedBox(
              height: 34.0,
              child: Text('若您未申請發票歸戶，中獎發票將寄發至您的訂購人地址。',
                  style: TextStyle(fontSize: 12.0, color: UdiColors.brownGrey)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Row(
              mainAxisAlignment: widget.isDefault
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.end,
              children: widget.isDefault ? [const DefaultIndicator()] : [],
            ),
          )
        ],
      ),
    );
  }
}
