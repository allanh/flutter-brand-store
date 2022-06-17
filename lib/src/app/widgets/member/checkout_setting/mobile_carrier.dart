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
    this.isExpand = false,
    this.code = '',
    required this.handleCollapse,
    required this.handleEapand,
    required this.handleSubmit,
  }) : super(key: key);

  @override
  bool isDefault;

  String? code;

  bool isExpand;

  Function handleCollapse;

  Function handleEapand;

  Function handleSubmit;

  @override
  State<MobileCarrier> createState() => _MobileCarrierState();
}

class _MobileCarrierState extends State<MobileCarrier> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void handleReset() {
      setState(() {
        _controller.text = '';
        widget.code = null;
      });
    }

    Text _title = Text(
      '個人-手機條碼載具',
      style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 14.0),
    );

    Text _hintMessage = Text(
      '"/"開頭，共8碼',
      style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 12.0),
    );

    Text _subtitle = Text(
      widget.code ?? '',
      style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 12.0),
    );

    TextStyle _hintStyle = Theme.of(context)
        .textTheme
        .caption!
        .copyWith(color: UdiColors.brownGrey2);

    SizedBox _codeInputField = SizedBox(
      height: 36.0,
      child: TextField(
        controller: _controller,
        textInputAction: TextInputAction.send,
        maxLength: 8,
        onChanged: (text) => setState(() => widget.code = text),
        cursorColor: UdiColors.veryLightGrey2,
        decoration: InputDecoration(
          labelText: widget.code,
          counterText: '',
          floatingLabelBehavior: FloatingLabelBehavior.never,
          contentPadding: const EdgeInsets.symmetric(horizontal: 18.0),
          hintText: '請輸入手機條碼',
          hintStyle: _hintStyle,
          border: _buildTextFieldBorder(),
          enabledBorder: _buildTextFieldBorder(),
          focusedBorder: _buildTextFieldBorder(),
        ),
      ),
    );

    CarrierActionButtons _carrierActionButtons = CarrierActionButtons(
      handleReset: () => handleReset(),
      handleSubmit: widget.code != null && widget.code!.isNotEmpty
          ? widget.handleSubmit(widget.code)
          : null,
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
          : [
              _carrierActionButtons,
            ],
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
                onPressed: () => widget.handleEapand(),
                icon: const Icon(Icons.edit_rounded),
                color: UdiColors.brownGrey,
              )
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
                _codeInputField,
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
