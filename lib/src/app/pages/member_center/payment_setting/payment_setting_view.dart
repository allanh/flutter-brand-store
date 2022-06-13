import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/constants.dart';

enum PaymentSettingType { credit, address, store, invoice }

class PaymentSettingPage extends StatelessWidget {
  const PaymentSettingPage({Key? key}) : super(key: key);

  void handleOpenPage(BuildContext context, PaymentSettingType type) {
    switch (type) {
      case PaymentSettingType.credit:
        break;
      case PaymentSettingType.address:
        break;
      case PaymentSettingType.store:
        break;
      case PaymentSettingType.invoice:
        context.pushNamed(invoiceSettingRouteName);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('結帳設定'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                  onPressed: () => debugPrint('open shopping cart'),
                  icon: const Icon(Icons.shopping_cart_outlined)),
            )
          ],
        ),
        body: ListView(
          children: [
            _buildListTile(
                context, '常用信用卡', PaymentSettingType.credit, handleOpenPage,
                badge: 4),
            const Divider(thickness: 1.0, color: UdiColors.veryLightGrey2),
            _buildListTile(
                context, '常用收件地址', PaymentSettingType.address, handleOpenPage,
                badge: 120),
            const Divider(thickness: 1.0, color: UdiColors.veryLightGrey2),
            _buildListTile(
                context, '常用超商門市', PaymentSettingType.store, handleOpenPage,
                badge: 10),
            const Divider(thickness: 1.0, color: UdiColors.veryLightGrey2),
            _buildListTile(
                context, '發票設定', PaymentSettingType.invoice, handleOpenPage,
                badge: 10),
            const Divider(thickness: 1.0, color: UdiColors.veryLightGrey2),
          ],
        ));
  }

  SizedBox _buildListTile(BuildContext context, String title,
      PaymentSettingType type, Function handleOpenPage,
      {int badge = 0}) {
    List<Widget> items = [
      const Icon(Icons.arrow_forward_ios_rounded,
          size: 20.0, color: UdiColors.brownGrey)
    ];
    const Color badgeColor = UdiColors.brownGrey2;
    const double badgeSize = 12.0;
    if (badge > 0) {
      items.insertAll(0, [
        Center(
          child: Container(
            decoration: BoxDecoration(
                color: badgeColor,
                border: Border.all(color: badgeColor),
                borderRadius:
                    const BorderRadius.all(Radius.circular(badgeSize))),
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(badge.toString(),
                textScaleFactor: 1.2,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: badgeSize,
                )),
          ),
        ),
        const SizedBox(width: 5.0),
      ]);
    }

    return SizedBox(
      height: 52.0,
      child: ListTile(
        onTap: () => handleOpenPage(context, type),
        contentPadding: const EdgeInsets.only(left: 24.0, right: 16.0),
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Row(children: items)]),
      ),
    );
  }
}
