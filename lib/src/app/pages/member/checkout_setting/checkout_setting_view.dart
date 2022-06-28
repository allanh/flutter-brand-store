import 'package:brandstores/src/data/repositories/member/data_invoice_setting_repository.dart';
import 'package:brandstores/src/data/repositories/member/data_shipping_infos_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/constants.dart';
import 'checkout_setting_controller.dart';

enum CheckoutSettingType { credit, address, store, invoice }

class CheckoutSettingPage extends View {
  CheckoutSettingPage({Key? key}) : super(key: key);

  @override
  _CheckoutSettingPageState createState() => _CheckoutSettingPageState();
}

class _CheckoutSettingPageState
    extends ViewState<CheckoutSettingPage, CheckoutSettingController> {
  _CheckoutSettingPageState()
      : super(
          CheckoutSettingController(
            DataShippingInfosRepository(),
            DataInvoiceSettingRepository(),
          ),
        );

  void handleOpenPage(
    BuildContext context,
    CheckoutSettingController controller,
    CheckoutSettingType type,
  ) {
    switch (type) {
      case CheckoutSettingType.credit:
        break;
      case CheckoutSettingType.address:
        context.pushNamed(
          shippingAddressRouteName,
          extra: controller.shippingInfos,
        );
        break;
      case CheckoutSettingType.store:
        break;
      case CheckoutSettingType.invoice:
        context.pushNamed(invoiceSettingRouteName);
        break;
    }
  }

  @override
  Widget get view {
    return ControlledWidgetBuilder<CheckoutSettingController>(
      builder: ((context, controller) {
        int invoicesBadge =
            controller.invoiceInfos?.validCarriers().length ?? 0;
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
              _buildListTile(context, controller, '常用信用卡',
                  CheckoutSettingType.credit, handleOpenPage,
                  badge: 4123),
              const Divider(thickness: 1.0, color: UdiColors.veryLightGrey2),
              _buildListTile(context, controller, '常用收件地址',
                  CheckoutSettingType.address, handleOpenPage,
                  badge: controller.shippingInfos?.length ?? 0),
              const Divider(thickness: 1.0, color: UdiColors.veryLightGrey2),
              _buildListTile(context, controller, '常用超商門市',
                  CheckoutSettingType.store, handleOpenPage,
                  badge: 1067894567),
              const Divider(thickness: 1.0, color: UdiColors.veryLightGrey2),
              _buildListTile(context, controller, '發票設定',
                  CheckoutSettingType.invoice, handleOpenPage,
                  badge: invoicesBadge),
              const Divider(thickness: 1.0, color: UdiColors.veryLightGrey2),
            ],
          ),
        );
      }),
    );
  }

  SizedBox _buildListTile(
      BuildContext context,
      CheckoutSettingController controller,
      String title,
      CheckoutSettingType type,
      Function handleOpenPage,
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
        onTap: () => handleOpenPage(context, controller, type),
        contentPadding: const EdgeInsets.only(left: 24.0, right: 16.0),
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Row(children: items)]),
      ),
    );
  }
}
