// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../device/utils/my_plus_colors.dart';
import 'carrier_action_buttons.dart';
import 'reorderable_card.dart';
import 'default_indicator.dart';

enum DonationType { genesis, jtf, other }

/// 捐贈發票
class DonationInvoiceCarrier extends StatefulWidget
    implements DefaultCarrierInterface {
  DonationInvoiceCarrier({
    Key? key,
    required this.isDefault,
  }) : super(key: key);

  @override
  bool isDefault;
  @override
  State<DonationInvoiceCarrier> createState() => _DonationInvoiceCarrierState();
}

class _DonationInvoiceCarrierState extends State<DonationInvoiceCarrier> {
  bool isGenesisChecked = false;
  bool isJtfChecked = false;
  bool isOtherChecked = false;

  DonationType selectedType = DonationType.genesis;

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.white;
    }
    return Theme.of(context).appBarTheme.backgroundColor!;
  }

  void handleCheckedValues(
    bool isGenesisCheckedValue,
    bool isJtfCheckedValue,
    bool isOtherCheckedValue,
  ) {
    isGenesisChecked = isGenesisCheckedValue;
    isJtfChecked = isJtfCheckedValue;
    isOtherChecked = isOtherCheckedValue;
  }

  @override
  Widget build(BuildContext context) {
    Text _searchButtonTitle = Text(
      '捐贈碼查詢',
      style: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.normal,
          color: Theme.of(context).appBarTheme.backgroundColor),
    );

    Text _donationTitle = const Text(
      '捐贈發票',
      style: TextStyle(fontSize: 14.0),
    );

    Text _hintTitle = const Text(
      '請選擇欲捐贈的機構',
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
              _donationTitle,
              CloseButton(
                onPressed: handleClose,
              ),
            ],
          ),
          _hintTitle,
          const SizedBox(height: 10.0),
          _buildCheckboxOption(context, DonationType.genesis,
              title: '創世基金會', value: isGenesisChecked),
          const SizedBox(height: 13.0),
          _buildCheckboxOption(context, DonationType.jtf,
              title: '董氏基金會', value: isJtfChecked),
          const SizedBox(height: 13.0),
          _buildCheckboxOption(context, DonationType.other,
              title: '其他機構', value: isOtherChecked),
          Row(children: [
            Padding(
              padding: const EdgeInsets.only(left: 40.0, top: 8.0),
              child: SizedBox(
                height: 36.0,
                width: 110.0,
                child: TextField(
                  cursorColor: UdiColors.veryLightGrey2,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 18.0),
                    hintText: '請輸入捐贈碼',
                    hintStyle: const TextStyle(
                      fontSize: 12.0,
                      color: UdiColors.brownGrey2,
                    ),
                    border: _buildTextFieldBorder(),
                    enabledBorder: _buildTextFieldBorder(),
                    focusedBorder: _buildTextFieldBorder(),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            InkWell(
              child: _searchButtonTitle,
              onTap: () {},
            ),
          ]),
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

  SizedBox _buildCheckboxOption(BuildContext context, DonationType type,
      {bool value = false, String title = ''}) {
    TextStyle style = Theme.of(context)
        .textTheme
        .caption!
        .copyWith(color: UdiColors.greyishBrown);

    return SizedBox(
      height: 24.0,
      child: Row(children: [
        _buildCheckbox(context, type, handleCheckedValues, value: value),
        Text(
          title,
          style: style,
        ),
      ]),
    );
  }

  Checkbox _buildCheckbox(BuildContext context, DonationType type,
      Function(bool, bool, bool) handleCheckedValues,
      {bool value = false}) {
    Color selectedColor = value
        ? Theme.of(context).appBarTheme.backgroundColor!
        : UdiColors.brownGrey2;

    return Checkbox(
        visualDensity: VisualDensity.compact,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        side: MaterialStateBorderSide.resolveWith(
          (states) => BorderSide(
            width: 1.0,
            color: selectedColor,
          ),
        ),
        fillColor: MaterialStateProperty.resolveWith(getColor),
        value: value,
        onChanged: (bool? value) {
          setState(() {
            handleCheckedValues(
              type == DonationType.genesis,
              type == DonationType.jtf,
              type == DonationType.other,
            );
          });
        });
  }

  OutlineInputBorder _buildTextFieldBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: UdiColors.veryLightGrey2, width: 1.0),
      borderRadius: BorderRadius.circular(4.0),
    );
  }
}
