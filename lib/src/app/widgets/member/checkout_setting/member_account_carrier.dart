// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../device/utils/my_plus_colors.dart';
import 'reorderable_card.dart';
import 'default_indicator.dart';

/// 會員載具
class MemberAccountCarrier extends StatefulWidget
    implements DefaultCarrierInterface {
  MemberAccountCarrier({
    Key? key,
    required this.isDefault,
    required this.id,
  }) : super(key: key);

  @override
  bool isDefault;

  String id = '';

  @override
  State<MemberAccountCarrier> createState() => _MemberAccountCarrierState();
}

class _MemberAccountCarrierState extends State<MemberAccountCarrier> {
  @override
  Widget build(BuildContext context) {
    void handleAction() {}

    Color _themeColor = Theme.of(context).appBarTheme.backgroundColor!;

    Text _actionTitle = Text(
      '發票歸戶',
      style: Theme.of(context).textTheme.caption!.copyWith(color: _themeColor),
    );

    SizedBox _actionButton = SizedBox(
      height: 24.0,
      width: 88.0,
      child: OutlinedButton(
        onPressed: handleAction,
        child: _actionTitle,
      ),
    );

    Text _carrierId = Text(
      '會員載具   ID:${widget.id}',
      style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 14.0),
    );

    Text _hintMessage = Text(
      '若您未申請發票歸戶，中獎發票將寄發至您的訂購人地址。',
      style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 12.0),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [_carrierId, _actionButton],
            ),
          ),
          const SizedBox(height: 12.0),
          Expanded(
            child: SizedBox(
              height: 34.0,
              child: _hintMessage,
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
