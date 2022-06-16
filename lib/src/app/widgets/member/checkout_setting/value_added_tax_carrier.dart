// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../device/utils/my_plus_colors.dart';
import 'carrier_action_buttons.dart';
import 'reorderable_card.dart';
import 'default_indicator.dart';

/// 公司-三聯式電子發票
class ValueAddedTaxCarrier extends StatefulWidget
    implements DefaultCarrierInterface {
  ValueAddedTaxCarrier({
    Key? key,
    required this.isDefault,
    this.isExpand = false,
    this.code = '',
    this.title = '',
    required this.handleCollapse,
    required this.handleExpand,
    required this.handleSubmit,
  }) : super(key: key);
  @override
  bool isDefault;

  String code;

  String title;

  bool isExpand;

  Function handleCollapse;

  Function handleExpand;

  Function handleSubmit;

  @override
  State<ValueAddedTaxCarrier> createState() => _ValueAddedTaxCarrierState();
}

class _ValueAddedTaxCarrierState extends State<ValueAddedTaxCarrier> {
  @override
  Widget build(BuildContext context) {
    TextStyle _hintStyle = Theme.of(context)
        .textTheme
        .caption!
        .copyWith(color: UdiColors.brownGrey2);

    SizedBox _taxIdInputTile = SizedBox(
      height: 36.0,
      child: TextField(
        onChanged: (text) => setState(() => widget.code = text),
        cursorColor: UdiColors.veryLightGrey2,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 18.0),
          hintText: '請輸入統一編號',
          hintStyle: _hintStyle,
          border: _buildTextFieldBorder(),
          enabledBorder: _buildTextFieldBorder(),
          focusedBorder: _buildTextFieldBorder(),
        ),
      ),
    );

    SizedBox _titleInputTile = SizedBox(
      height: 36.0,
      child: TextField(
        onChanged: (text) => setState(() => widget.title = text),
        cursorColor: UdiColors.veryLightGrey2,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 18.0),
          hintText: '請輸入發票抬頭',
          hintStyle: _hintStyle,
          border: _buildTextFieldBorder(),
          enabledBorder: _buildTextFieldBorder(),
          focusedBorder: _buildTextFieldBorder(),
        ),
      ),
    );

    Text _title = Text(
      '公司-三聯式電子發票',
      style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 14.0),
    );

    Text _hintMessage = Text(
      '於鑑賞期過後寄出電子發票至訂購人Email。',
      style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 12.0),
    );

    Text _taxIdTitle = Text(
      '統一編號*',
      style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 14.0),
    );

    Text _companyTitle = Text(
      '發票抬頭',
      style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 14.0),
    );

    void handleReset() {}

    CarrierActionButtons _carrierActionButtons = CarrierActionButtons(
      handleReset: handleReset,
      handleSubmit: widget.code.isEmpty || widget.title.isEmpty
          ? null
          : () => widget.handleSubmit(
                widget.code,
                widget.title,
              ),
    );

    Row _topRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _title,
        widget.isExpand
            ? CloseButton(
                onPressed: () => widget.handleCollapse(),
              )
            : IconButton(
                onPressed: () => widget.handleExpand(),
                icon: const Icon(Icons.edit_rounded),
                color: UdiColors.brownGrey,
              )
      ],
    );
    Row _bottomRow = Row(
      mainAxisAlignment: widget.isDefault
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.end,
      children: widget.isDefault
          ? [
              const DefaultIndicator(),
              _carrierActionButtons,
            ]
          : [_carrierActionButtons],
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.isExpand
            ? [
                _topRow,
                _hintMessage,
                const SizedBox(height: 12.0),
                const Divider(
                  height: 1.0,
                  color: UdiColors.veryLightGrey2,
                ),
                const SizedBox(height: 12.0),
                _taxIdTitle,
                const SizedBox(height: 8.0),
                _taxIdInputTile,
                const SizedBox(height: 15.0),
                _companyTitle,
                const SizedBox(height: 8.0),
                _titleInputTile,
                const SizedBox(height: 20.0),
                _bottomRow
              ]
            : [_topRow],
      ),
    );
  }

  OutlineInputBorder _buildTextFieldBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: UdiColors.veryLightGrey2, width: 1.0),
      borderRadius: BorderRadius.circular(4.0),
    );
  }
}
