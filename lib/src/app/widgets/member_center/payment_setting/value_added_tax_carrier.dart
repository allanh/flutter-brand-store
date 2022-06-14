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
  }) : super(key: key);
  @override
  bool isDefault;

  @override
  State<ValueAddedTaxCarrier> createState() => _ValueAddedTaxCarrierState();
}

class _ValueAddedTaxCarrierState extends State<ValueAddedTaxCarrier> {
  @override
  Widget build(BuildContext context) {
    SizedBox _taxIdInputTile = SizedBox(
      height: 36.0,
      child: TextField(
        cursorColor: UdiColors.veryLightGrey2,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 18.0),
          hintText: '請輸入統一編號',
          hintStyle: const TextStyle(
            fontSize: 14.0,
            color: UdiColors.brownGrey2,
          ),
          border: _buildTextFieldBorder(),
          enabledBorder: _buildTextFieldBorder(),
          focusedBorder: _buildTextFieldBorder(),
        ),
      ),
    );

    SizedBox _titleInputTile = SizedBox(
      height: 36.0,
      child: TextField(
        cursorColor: UdiColors.veryLightGrey2,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 18.0),
          hintText: '請輸入發票抬頭',
          hintStyle: const TextStyle(
            fontSize: 14.0,
            color: UdiColors.brownGrey2,
          ),
          border: _buildTextFieldBorder(),
          enabledBorder: _buildTextFieldBorder(),
          focusedBorder: _buildTextFieldBorder(),
        ),
      ),
    );

    Text _title = const Text(
      '公司-三聯式電子發票',
      style: TextStyle(fontSize: 14.0),
    );

    Text _hintMessage = const Text(
      '於鑑賞期過後寄出電子發票至訂購人Email。',
      style: TextStyle(fontSize: 12.0, color: UdiColors.brownGrey),
    );

    Text _taxIdTitle = const Text(
      '統一編號*',
      style: TextStyle(fontSize: 14.0),
    );

    Text _companyTitle = const Text(
      '發票抬頭',
      style: TextStyle(fontSize: 14.0),
    );

    void handleClose() {}

    void handleReset() {}

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _title,
              CloseButton(
                onPressed: handleClose,
              )
            ],
          ),
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
          Row(
            mainAxisAlignment: widget.isDefault
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.end,
            children: widget.isDefault
                ? [
                    const DefaultIndicator(),
                    CarrierActionButtons(
                      handleReset: handleReset,
                      handleSubmit: null,
                    ),
                  ]
                : [
                    CarrierActionButtons(
                      handleReset: handleReset,
                      handleSubmit: null,
                    )
                  ],
          )
        ],
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
