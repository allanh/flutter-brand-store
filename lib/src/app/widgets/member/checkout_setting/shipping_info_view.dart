import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/member/shipping_info.dart';
import 'default_indicator.dart';
import 'reorderable_card.dart';

class ShippingInfoView extends StatefulWidget
    implements DefaultCarrierInterface {
  ShippingInfoView({
    Key? key,
    required this.isDefault,
    required this.info,
    required this.handleEdit,
    required this.handleDelete,
  }) : super(key: key);

  @override
  bool isDefault;

  ShippingInfo info;

  Function handleEdit;

  Function handleDelete;

  @override
  State<ShippingInfoView> createState() => _ShippingInfoViewState();
}

class _ShippingInfoViewState extends State<ShippingInfoView> {
  @override
  Widget build(BuildContext context) {
    final _title = Text(
      widget.info.infoName ?? '',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 14.0),
    );

    final _name = Text(
      '收件人：${widget.info.sensitiveName}',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 14.0),
    );

    final _mobile = Text(
      '手機：${widget.info.sensitiveMobile}',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 14.0),
    );

    final _phone = Text(
      '市話：${widget.info.sensitivePhone}',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 14.0),
    );

    final _address = Text(
      '地址：${widget.info.sensitiveAddress}',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 14.0),
    );

    final _editButton = IconButton(
      icon: const Icon(Icons.edit),
      color: UdiColors.brownGrey,
      iconSize: 28.0,
      visualDensity: VisualDensity.compact,
      onPressed: () => widget.handleEdit(),
    );

    final _deleteButton = IconButton(
      icon: const Icon(Icons.delete),
      color: UdiColors.brownGrey,
      iconSize: 28.0,
      visualDensity: VisualDensity.compact,
      onPressed: () => widget.handleDelete(),
    );

    final _actionButtons = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_editButton, _deleteButton],
    );

    final _bottomRow = Row(
      mainAxisAlignment: widget.isDefault
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.end,
      children: widget.isDefault
          ? [
              const DefaultIndicator(),
              _actionButtons,
            ]
          : [
              _actionButtons,
            ],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 12.0),
        _title,
        const SizedBox(height: 6.0),
        _name,
        const SizedBox(height: 2.0),
        _mobile,
        const SizedBox(height: 2.0),
        _phone,
        const SizedBox(height: 2.0),
        _address,
        const SizedBox(height: 2.0),
        _bottomRow,
      ]),
    );
  }
}
