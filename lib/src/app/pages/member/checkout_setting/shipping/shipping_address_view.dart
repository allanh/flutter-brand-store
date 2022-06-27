import 'package:flutter/material.dart';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'shipping_address_controller.dart';

class ShippingAddressPage extends View {
  ShippingAddressPage({Key? key}) : super(key: key);

  @override
  _ShippingAddressPageState createState() => _ShippingAddressPageState();
}

class _ShippingAddressPageState
    extends ViewState<ShippingAddressPage, ShippingAddressController> {
  _ShippingAddressPageState()
      : super(
          ShippingAddressController(),
        );

  BuildContext? _context;

  @override
  Widget get view {
    return ControlledWidgetBuilder(builder: (context, controller) {
      _context = context;
      return Scaffold(
          appBar: AppBar(title: const Text('常用收件地址')),
          body: Center(
            child: const Text('address'),
          ));
    });
  }
}
