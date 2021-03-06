// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'reorderable_card.dart';
import 'default_indicator.dart';

/// 會員載具
class MembershipCarrierInfo extends StatefulWidget
    implements DefaultCarrierInterface {
  MembershipCarrierInfo({
    Key? key,
    required this.isDefault,
    required this.id,
    required this.handleMembershipCarrierRegister,
  }) : super(key: key);

  @override
  bool isDefault;

  String? id = '';

  Function handleMembershipCarrierRegister;

  @override
  State<MembershipCarrierInfo> createState() => _MembershipCarrierInfoState();
}

class _MembershipCarrierInfoState extends State<MembershipCarrierInfo> {
  @override
  Widget build(BuildContext context) {
    Color _themeColor = Theme.of(context).appBarTheme.backgroundColor!;

    Text _actionTitle = Text(
      '發票歸戶',
      style: Theme.of(context).textTheme.caption!.copyWith(color: _themeColor),
    );

    Text _carrierId = Text(
      '會員載具   ID:${widget.id}',
      style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 14.0),
    );

    Text _hintMessage = Text(
      '若您未申請發票歸戶，中獎發票將寄發至您的訂購人地址。',
      style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 12.0),
    );

    SizedBox _actionButton = SizedBox(
      height: 24.0,
      width: 88.0,
      child: OutlinedButton(
        onPressed: () => widget.handleMembershipCarrierRegister(),
        child: _actionTitle,
      ),
    );

    Padding _topRow = Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_carrierId, _actionButton],
      ),
    );

    Expanded _hintMessageRow = Expanded(
      child: SizedBox(
        height: 34.0,
        child: _hintMessage,
      ),
    );

    Padding _bottomRow = Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        mainAxisAlignment: widget.isDefault
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.end,
        children: widget.isDefault ? [const DefaultIndicator()] : [],
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.isDefault
            ? [
                _topRow,
                const SizedBox(height: 12.0),
                _hintMessageRow,
                _bottomRow
              ]
            : [
                _topRow,
                const SizedBox(height: 12.0),
                _hintMessageRow,
              ],
      ),
    );
  }
}
