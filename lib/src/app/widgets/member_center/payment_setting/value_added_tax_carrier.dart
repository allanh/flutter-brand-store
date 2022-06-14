import 'package:flutter/material.dart';

import '../../../../device/utils/my_plus_colors.dart';
import 'carrier_action_buttons.dart';
import 'carrier_card.dart';
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
    SizedBox taxIdInput = SizedBox(
      height: 36.0,
      child: TextField(
        cursorColor: UdiColors.veryLightGrey2,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 18.0),
            hintText: '請輸入統一編號',
            hintStyle:
                const TextStyle(fontSize: 14.0, color: UdiColors.brownGrey2),
            border: _buildTextFieldBorder(),
            enabledBorder: _buildTextFieldBorder(),
            focusedBorder: _buildTextFieldBorder()),
      ),
    );

    SizedBox titleInput = SizedBox(
      height: 36.0,
      child: TextField(
        cursorColor: UdiColors.veryLightGrey2,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 18.0),
            hintText: '請輸入發票抬頭',
            hintStyle:
                const TextStyle(fontSize: 14.0, color: UdiColors.brownGrey2),
            border: _buildTextFieldBorder(),
            enabledBorder: _buildTextFieldBorder(),
            focusedBorder: _buildTextFieldBorder()),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('公司-三聯式電子發票', style: TextStyle(fontSize: 14.0)),
              CloseButton(onPressed: () {})
            ],
          ),
          const Text('於鑑賞期過後寄出電子發票至訂購人Email。',
              style: TextStyle(fontSize: 12.0, color: UdiColors.brownGrey)),
          const SizedBox(height: 12.0),
          const Divider(height: 1.0, color: UdiColors.veryLightGrey2),
          const SizedBox(height: 12.0),
          const Text('統一編號*', style: TextStyle(fontSize: 14.0)),
          const SizedBox(height: 8.0),
          taxIdInput,
          const SizedBox(height: 15.0),
          const Text('發票抬頭', style: TextStyle(fontSize: 14.0)),
          const SizedBox(height: 8.0),
          titleInput,
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: widget.isDefault
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.end,
            children: widget.isDefault
                ? [
                    const DefaultIndicator(),
                    const CarrierActionButtons(),
                  ]
                : [const CarrierActionButtons()],
          )
        ],
      ),
    );
  }

  OutlineInputBorder _buildTextFieldBorder() {
    return OutlineInputBorder(
        borderSide:
            const BorderSide(color: UdiColors.veryLightGrey2, width: 1.0),
        borderRadius: BorderRadius.circular(4.0));
  }
}
