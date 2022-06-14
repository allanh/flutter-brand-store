// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../device/utils/my_plus_colors.dart';
import 'carrier_action_buttons.dart';
import 'reorderable_card.dart';
import 'default_indicator.dart';

/// 個人-自然人憑證
class CitizenDigitalCertificateCarrier extends StatefulWidget
    implements DefaultCarrierInterface {
  CitizenDigitalCertificateCarrier({
    Key? key,
    required this.isDefault,
  }) : super(key: key);
  @override
  bool isDefault;
  @override
  State<CitizenDigitalCertificateCarrier> createState() =>
      _CitizenDigitalCertificateCarrierState();
}

class _CitizenDigitalCertificateCarrierState
    extends State<CitizenDigitalCertificateCarrier> {
  @override
  Widget build(BuildContext context) {
    SizedBox _certificateCodeInputTile = SizedBox(
      height: 36.0,
      child: TextField(
        cursorColor: UdiColors.veryLightGrey2,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 18.0),
          hintText: '請輸入自然人憑證',
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

    Text _hintMessage = const Text(
      '自然人憑證條碼為卡片右下方，前兩碼為大寫英文，後14碼為數字，共16碼。',
      style: TextStyle(
        fontSize: 12.0,
        color: UdiColors.brownGrey,
      ),
    );

    Text _title = const Text(
      '個人-自然人憑證',
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
            const SizedBox(height: 6.0),
            _certificateCodeInputTile,
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
        ));
  }

  OutlineInputBorder _buildTextFieldBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: UdiColors.veryLightGrey2, width: 1.0),
      borderRadius: BorderRadius.circular(4.0),
    );
  }
}
