// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../../domain/entities/member/shipping_info.dart';
import 'shipping_info_detail_controller.dart';

class ShippingInfoDetailPage extends View {
  ShippingInfoDetailPage({
    Key? key,
    this.info,
  }) : super(key: key);

  ShippingInfo? info;

  @override
  _ShippingInfoDetailPageState createState() => _ShippingInfoDetailPageState();
}

class _ShippingInfoDetailPageState
    extends ViewState<ShippingInfoDetailPage, ShippingInfoDetailController> {
  _ShippingInfoDetailPageState()
      : super(
          ShippingInfoDetailController(),
        );

  @override
  Widget get view => ControlledWidgetBuilder<ShippingInfoDetailController>(
        builder: (context, controller) {
          final _appBar = AppBar(title: const Text('新增常用收件地址'));

          return Scaffold(
            appBar: _appBar,
            body: const Center(
              child: Text('SHIPPING INFO DETAIL'),
            ),
          );
        },
      );
}
