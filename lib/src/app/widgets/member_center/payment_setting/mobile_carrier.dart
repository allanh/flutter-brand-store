// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../device/utils/my_plus_colors.dart';
import 'carrier_action_buttons.dart';
import 'reorderable_card.dart';
import 'default_indicator.dart';

/// 個人-手機條碼載具
class MobileCarrier extends StatefulWidget implements DefaultCarrierInterface {
  MobileCarrier({
    Key? key,
    required this.isDefault,
  }) : super(key: key);

  @override
  bool isDefault;

  @override
  State<MobileCarrier> createState() => _MobileCarrierState();
}

class _MobileCarrierState extends State<MobileCarrier> {
  @override
  Widget build(BuildContext context) {
    Text _title = const Text('個人-手機條碼載具', style: TextStyle(fontSize: 14.0));

    Text _hintMessage = const Text(
      '"/"開頭，共8碼',
      style: TextStyle(fontSize: 12.0, color: UdiColors.brownGrey),
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
          const SizedBox(height: 6.0),
          SizedBox(
            height: 36.0,
            child: TextField(
              cursorColor: UdiColors.veryLightGrey2,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 18.0),
                hintText: '請輸入手機條碼',
                hintStyle: const TextStyle(
                  fontSize: 14.0,
                  color: UdiColors.brownGrey2,
                ),
                border: _buildTextFieldBorder(),
                enabledBorder: _buildTextFieldBorder(),
                focusedBorder: _buildTextFieldBorder(),
              ),
            ),
          ),
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
                    ),
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
