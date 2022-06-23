// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../device/utils/my_plus_colors.dart';
import '../../../../domain/entities/member/invoice.dart';
import 'carrier_action_buttons.dart';
import 'reorderable_card.dart';
import 'default_indicator.dart';

/// 捐贈發票
class DonationInvoiceCarrier extends StatefulWidget
    implements DefaultCarrierInterface {
  DonationInvoiceCarrier({
    Key? key,
    required this.isDefault,
    this.isExpand = false,
    this.npos,
    required this.handleCollpase,
    required this.handleExpand,
    required this.handleSubmit,
    required this.handleOpenDonationCodeWeb,
  }) : super(key: key);

  @override
  bool isDefault;

  List<NPO>? npos;

  bool isExpand;

  Function handleCollpase;

  Function handleExpand;

  Function handleSubmit;

  Function handleOpenDonationCodeWeb;

  @override
  State<DonationInvoiceCarrier> createState() => _DonationInvoiceCarrierState();
}

class _DonationInvoiceCarrierState extends State<DonationInvoiceCarrier> {
  NPO? _selectedNPO;

  String? _selectedId;

  final TextEditingController _controller = TextEditingController();

  void handleSelectionChange(String id) {
    setState(() {
      handleEnabledStatusChange(id);
      _selectedId = id;
    });
  }

  void handleEnabledStatusChange(String id) {
    widget.npos?.forEach((npo) => npo.isEnabled = npo.npoId == id);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// 確保 NPO 為空陣列，才能加入其他機構選項
    widget.npos ??= [];

    /// 檢查是否有 id 為 -1 的機構，如果有在陣列中，
    /// 表示已經加入過其他機構選項
    if (widget.npos!.isNotEmpty &&
        widget.npos?.last.npoId != '-1' &&
        widget.npos?.last.type != NPOType.other) {
      /// 加入其他機構選項
      widget.npos?.insert(
          widget.npos?.length ?? 0, NPO(NPOType.other, '-1', '其他機構', false));
    }

    /// 檢查是否有預設的愛心碼
    final List<NPO>? defaultNPO =
        widget.npos?.where((npo) => npo.isEnabled).toList();
    if (defaultNPO != null && defaultNPO.isNotEmpty && _selectedId == null) {
      _selectedNPO = defaultNPO.first;
      _selectedId = defaultNPO.first.npoId;
    }

    Text _searchButtonTitle = Text(
      '捐贈碼查詢',
      style: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.normal,
          color: Theme.of(context).appBarTheme.backgroundColor),
    );

    Text _donationTitle = Text(
      '捐贈發票',
      style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 14.0),
    );

    Text _subtitle = Text(
      '${_selectedNPO?.title}, ${_selectedNPO?.npoId}',
      style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 12.0),
    );

    Text _hintTitle = Text(
      '請選擇欲捐贈的機構',
      style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 12.0),
    );

    void handleReset() {
      setState(() {
        _selectedId = '';
        _controller.clear();
        handleEnabledStatusChange('');
      });
    }

    bool handleEnableSubmit() {
      /// 如果選擇其他機構但是沒有輸入捐贈碼
      /// 必須將儲存按鈕反灰
      bool disable =
          _selectedNPO?.isEnabled == false && _controller.text.isEmpty;

      return disable;
    }

    void handleDonationChange(donation) {
      debugPrint(donation);
      setState(() {
        _selectedId = donation;
        widget.npos?.last.npoId = _selectedId;
        handleEnabledStatusChange(donation);
      });
    }

    Row _topRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _donationTitle,
        widget.isExpand
            ? CloseButton(
                onPressed: () => widget.handleCollpase(),
              )
            : IconButton(
                onPressed: () => widget.handleExpand(),
                icon: const Icon(Icons.edit_rounded),
                color: UdiColors.brownGrey,
              ),
      ],
    );

    TextStyle _hintStyle = Theme.of(context).textTheme.caption!.copyWith(
          color: UdiColors.brownGrey2,
          fontSize: 12.0,
        );

    Row inputCodeRow = Row(children: [
      Padding(
        padding: const EdgeInsets.only(left: 40.0, top: 8.0),
        child: SizedBox(
          height: 36.0,
          width: 110.0,
          child: TextField(
            controller: _controller,
            onChanged: (text) => handleDonationChange(text),
            cursorColor: UdiColors.veryLightGrey2,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding: const EdgeInsets.symmetric(horizontal: 18.0),
              hintText: '請輸入捐贈碼',
              hintStyle: _hintStyle,
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
        onTap: () => widget.handleOpenDonationCodeWeb(),
      ),
    ]);

    CarrierActionButtons _carrierActionButtons = CarrierActionButtons(
      handleReset: () => handleReset(),
      handleSubmit:

          /// 如果選擇其他機構但是沒有輸入捐贈碼
          /// 必須將儲存按鈕反灰
          handleEnableSubmit() ? null : () => widget.handleSubmit(_selectedId),
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

    List<Widget> children = [
      _topRow,
      _hintTitle,
      const SizedBox(height: 10.0),
      inputCodeRow,
      const SizedBox(height: 20.0),
      _bottomRow
    ];
    if (widget.isExpand) {
      children.insertAll(
        3,
        _buildRadioListTile(
          context,
          widget.npos!,
        ),
      );
    } else {
      children =
          _selectedId == null || (_selectedId != null && _selectedId!.isEmpty)
              ? [
                  _topRow,
                ]
              : [
                  _topRow,
                  _subtitle,
                ];
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  List<RadioListTile> _buildRadioListTile(
    BuildContext context,
    List<NPO> npos,
  ) {
    return List.generate(
        npos.length,
        (index) => RadioListTile(
              dense: true,
              activeColor: Theme.of(context).appBarTheme.backgroundColor,
              contentPadding: const EdgeInsets.only(right: 15.0),
              visualDensity: VisualDensity.compact,
              title: Text(
                npos[index].title!,
                style: Theme.of(context).textTheme.caption,
                maxLines: 1,
              ),
              groupValue: _selectedId,
              value: npos[index].npoId,
              onChanged: (npo) => handleSelectionChange(npo),
            ));
  }

  OutlineInputBorder _buildTextFieldBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: UdiColors.veryLightGrey2, width: 1.0),
      borderRadius: BorderRadius.circular(4.0),
    );
  }
}
