// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../device/utils/my_plus_colors.dart';
import 'carrier_action_buttons.dart';
import 'reorderable_card.dart';
import 'default_indicator.dart';

/// 公司-三聯式電子發票
class ValueAddedTaxCarrierInfo extends StatefulWidget
    implements DefaultCarrierInterface {
  ValueAddedTaxCarrierInfo({
    Key? key,
    required this.isDefault,
    this.isExpand = false,
    this.code = '',
    this.title = '',
    required this.isValidVatId,
    required this.handleExpand,
    required this.handleSubmit,
    required this.handleVatIdChange,
  }) : super(key: key);
  @override
  bool isDefault;

  String? code;

  String? title;

  bool isExpand;

  Function handleExpand;

  Function handleSubmit;

  bool isValidVatId;

  Function handleVatIdChange;

  @override
  State<ValueAddedTaxCarrierInfo> createState() =>
      _ValueAddedTaxCarrierInfoState();
}

class _ValueAddedTaxCarrierInfoState extends State<ValueAddedTaxCarrierInfo> {
  final TextEditingController _vatIdController = TextEditingController();
  final TextEditingController _vatTitleController = TextEditingController();
  @override
  void dispose() {
    _vatIdController.dispose();
    _vatTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void handleReset() {
      setState(() {
        _vatIdController.clear();
        _vatTitleController.clear();
        widget.title = null;
        widget.code = null;
      });
    }

    Text _title = Text(
      '公司-三聯式電子發票',
      style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 14.0),
    );

    Text _hintMessage = Text(
      '於鑑賞期過後寄出電子發票至訂購人Email。',
      style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 12.0),
    );

    Text _subtitle = Text(
      '${widget.code}, ${widget.title}',
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

    TextStyle _hintStyle = Theme.of(context)
        .textTheme
        .caption!
        .copyWith(color: UdiColors.brownGrey2);

    SizedBox _vatIdInputTile = SizedBox(
      height: 36.0,
      child: TextField(
        controller: _vatIdController,
        textInputAction: TextInputAction.send,
        maxLength: 8,
        onChanged: (text) => widget.handleVatIdChange(text),
        cursorColor: UdiColors.veryLightGrey2,
        decoration: InputDecoration(
          labelText: widget.code,
          counterText: '',
          floatingLabelBehavior: FloatingLabelBehavior.never,
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
        controller: _vatTitleController,
        textInputAction: TextInputAction.send,
        onChanged: (text) => setState(() => widget.title = text),
        cursorColor: UdiColors.veryLightGrey2,
        decoration: InputDecoration(
          labelText: widget.title,
          counterText: '',
          floatingLabelBehavior: FloatingLabelBehavior.never,
          contentPadding: const EdgeInsets.symmetric(horizontal: 18.0),
          hintText: '請輸入發票抬頭',
          hintStyle: _hintStyle,
          border: _buildTextFieldBorder(),
          enabledBorder: _buildTextFieldBorder(),
          focusedBorder: _buildTextFieldBorder(),
        ),
      ),
    );

    CarrierActionButtons _carrierActionButtons = CarrierActionButtons(
      handleReset: () => handleReset(),
      handleSubmit: widget.code != null &&
              widget.code!.isNotEmpty &&
              widget.title != null &&
              widget.title!.isNotEmpty
          ? () => widget.handleSubmit(
                widget.code,
                widget.title,
              )
          : null,
    );

    Row _topRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _title,
        widget.isExpand
            ? CloseButton(
                onPressed: () => widget.handleExpand(),
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
                _vatIdInputTile,
                const SizedBox(height: 15.0),
                _companyTitle,
                const SizedBox(height: 8.0),
                _titleInputTile,
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
