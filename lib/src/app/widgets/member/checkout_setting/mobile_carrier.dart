// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../device/utils/my_plus_colors.dart';
import 'carrier_action_buttons.dart';
import 'reorderable_card.dart';
import 'default_indicator.dart';

/// 個人-手機條碼載具
class MobileCarrierInfo extends StatefulWidget
    implements DefaultCarrierInterface {
  MobileCarrierInfo({
    Key? key,
    required this.isDefault,
    this.isExpand = false,
    this.code = '',
    required this.isValid,
    required this.handleEapand,
    required this.handleSubmit,
    required this.handleCarrierChange,
  }) : super(key: key);

  @override
  bool isDefault;

  String? code;

  bool isExpand;

  bool isValid;

  Function handleEapand;

  Function handleSubmit;

  Function handleCarrierChange;

  @override
  State<MobileCarrierInfo> createState() => _MobileCarrierInfoState();
}

class _MobileCarrierInfoState extends State<MobileCarrierInfo> {
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
        _controller.clear();
        widget.code = null;
      });
    }

    double height = 36.0 + (widget.isValid ? 0 : 30.0);

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
      height: height,
      child: TextField(
        controller: _controller,
        textInputAction: TextInputAction.send,
        maxLength: 8,
        onChanged: (text) => widget.handleCarrierChange(text),
        cursorColor: UdiColors.veryLightGrey2,
        decoration: InputDecoration(
          labelText: widget.code,
          counterText: '',
          floatingLabelBehavior: FloatingLabelBehavior.never,
          contentPadding: const EdgeInsets.symmetric(horizontal: 18.0),
          hintText: '請輸入手機條碼',
          hintStyle: _hintStyle,
          errorText: widget.isValid ? null : '請輸入有效手機條碼!',
          errorStyle: Theme.of(context).textTheme.caption?.copyWith(
                color: UdiColors.strawberry,
                fontSize: 12.0,
              ),
          errorBorder: _buildTextFieldBorder(color: UdiColors.strawberry),
          focusedErrorBorder:
              _buildTextFieldBorder(color: UdiColors.strawberry),
          border: _buildTextFieldBorder(color: UdiColors.veryLightGrey2),
          enabledBorder: _buildTextFieldBorder(color: UdiColors.veryLightGrey2),
          focusedBorder: _buildTextFieldBorder(color: UdiColors.veryLightGrey2),
        ),
      ),
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
                onPressed: () => widget.handleEapand(),
              )
            : IconButton(
                onPressed: () => widget.handleEapand(),
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

  OutlineInputBorder _buildTextFieldBorder({required Color color}) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 1.0),
      borderRadius: BorderRadius.circular(4.0),
    );
  }
}
