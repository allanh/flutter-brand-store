// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../device/utils/my_plus_colors.dart';
import 'carrier_action_buttons.dart';
import 'reorderable_card.dart';
import 'default_indicator.dart';

/// 個人-自然人憑證
class CitizenDigitalCarrierInfo extends StatefulWidget
    implements DefaultCarrierInterface {
  CitizenDigitalCarrierInfo({
    Key? key,
    required this.isDefault,
    this.isExpand = false,
    this.code = '',
    required this.handleCollapse,
    required this.handleExpand,
    required this.handleSubmit,
  }) : super(key: key);
  @override
  bool isDefault;

  String? code;

  bool isExpand;

  Function handleCollapse;

  Function handleExpand;

  Function handleSubmit;

  @override
  State<CitizenDigitalCarrierInfo> createState() => _CitizenDigitalCarrierInfoState();
}

class _CitizenDigitalCarrierInfoState extends State<CitizenDigitalCarrierInfo> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void handleReset() {
      _controller.text = '';
      widget.code = null;
    }

    TextStyle _hintStyle = Theme.of(context)
        .textTheme
        .caption!
        .copyWith(color: UdiColors.brownGrey2);

    SizedBox _certificateCodeInputTile = SizedBox(
      height: 36.0,
      child: TextField(
        controller: _controller,
        textInputAction: TextInputAction.send,
        maxLength: 16,
        onChanged: (text) => setState(() => widget.code = text),
        cursorColor: UdiColors.veryLightGrey2,
        decoration: InputDecoration(
          labelText: widget.code,
          counterText: '',
          floatingLabelBehavior: FloatingLabelBehavior.never,
          contentPadding: const EdgeInsets.symmetric(horizontal: 18.0),
          hintText: '請輸入自然人憑證',
          hintStyle: _hintStyle,
          border: _buildTextFieldBorder(),
          enabledBorder: _buildTextFieldBorder(),
          focusedBorder: _buildTextFieldBorder(),
        ),
      ),
    );

    Text _hintMessage = Text(
      '自然人憑證條碼為卡片右下方，前兩碼為大寫英文，後14碼為數字，共16碼。',
      style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 12.0),
    );

    Text _title = Text(
      '個人-自然人憑證',
      style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 14.0),
    );

    Text _subtitle = Text(
      widget.code ?? '',
      style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 12.0),
    );

    CarrierActionButtons _carrierActionButtons = CarrierActionButtons(
      handleReset: () => handleReset(),
      handleSubmit: widget.code != null && widget.code!.isNotEmpty
          ? () => widget.handleSubmit(widget.code)
          : null,
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
    var _bottomRow = Row(
      mainAxisAlignment: widget.isDefault
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.end,
      children: widget.isDefault
          ? [
              const DefaultIndicator(),
              _carrierActionButtons,
            ]
          : [
              _carrierActionButtons,
            ],
    );
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.isExpand
              ? [
                  _topRow,
                  _hintMessage,
                  const SizedBox(height: 6.0),
                  _certificateCodeInputTile,
                  const SizedBox(height: 20.0),
                  _bottomRow
                ]
              : widget.code != null && widget.code!.isNotEmpty
                  ? [
                      _topRow,
                      _subtitle,
                    ]
                  : [
                      _topRow,
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
