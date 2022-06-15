import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../../data/repositories/member_center/data_invoice_setting_repository.dart';
import '../../../../widgets/member_center/payment_setting/reorderable_card.dart';
import '../../../../widgets/member_center/payment_setting/citizen_digital_certification_carrier.dart';
import '../../../../widgets/member_center/payment_setting/donation_invoice_carrier.dart';
import '../../../../widgets/member_center/payment_setting/member_account_carrier.dart';
import '../../../../widgets/member_center/payment_setting/mobile_carrier.dart';
import '../../../../widgets/member_center/payment_setting/value_added_tax_carrier.dart';
import 'invoice_setting_controller.dart';

class InvoiceSettingPage extends View {
  InvoiceSettingPage({
    Key? key,
  }) : super(key: key);

  @override
  _InvoiceSettingPageState createState() => _InvoiceSettingPageState();
}

class _InvoiceSettingPageState
    extends ViewState<InvoiceSettingPage, InvoiceSettingController> {
  _InvoiceSettingPageState()
      : super(
          InvoiceSettingController(
            DataInvoiceSettingRepository(),
          ),
        );

  final List<ReorderableCard> _carrierCards = <ReorderableCard>[
    /// 會員載具
    ReorderableCard(
        key: const Key('0'),
        item: MemberAccountCarrier(isDefault: true, id: '202021211345'),
        height: 120.0,
        isSelected: true),

    /// 個人-手機條碼載具
    ReorderableCard(
        key: const Key('1'),
        item: MobileCarrier(isDefault: false),
        height: 171.0,
        isSelected: false),

    /// 個人-自然人憑證
    ReorderableCard(
        key: const Key('2'),
        item: CitizenDigitalCertificateCarrier(isDefault: false),
        height: 190.0,
        isSelected: false),

    /// 公司-三聯式電子發票
    ReorderableCard(
        key: const Key('3'),
        item: ValueAddedTaxCarrier(isDefault: false),
        height: 305.0,
        isSelected: false),

    /// 捐贈發票
    ReorderableCard(
        key: const Key('4'),
        item: DonationInvoiceCarrier(isDefault: false),
        height: 290.0,
        isSelected: false),
  ];

  void handleCarriers(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final ReorderableCard _carrier = _carrierCards.removeAt(oldIndex);
    _carrierCards.insert(newIndex, _carrier);
    _carrierCards.asMap().forEach((index, card) {
      card.isSelected = index == 0;
      if (card.item is DefaultCarrierInterface) {
        (card.item as DefaultCarrierInterface).isDefault =
            _carrierCards.indexOf(card) == 0;
      }
    });
  }

  Widget header = Builder(builder: (context) {
    return Column(
      children: [
        const SizedBox(height: 12.0),
        Text('結帳時，發票預設為會員載具，您可以設定其他常用的發票資料。',
            style: Theme.of(context)
                .textTheme
                .caption
                ?.copyWith(color: UdiColors.brownGrey)),
        const SizedBox(height: 12.0),
        Row(
          children: [
            Container(
                color: Theme.of(context).appBarTheme.backgroundColor,
                height: 24.0,
                width: 4.0),
            const SizedBox(
              width: 6.0,
            ),
            Text('預設發票設定',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: UdiColors.greyishBrown))
          ],
        ),
        const SizedBox(height: 12.0),
      ],
    );
  });

  @override
  Widget get view {
    return ControlledWidgetBuilder<InvoiceSettingController>(
        builder: (context, controller) {
      return Scaffold(
          appBar: AppBar(title: const Text('發票設定')),
          body: Padding(
            padding: const EdgeInsets.only(bottom: 44.0),
            child: ReorderableListView(
              proxyDecorator: (child, index, animation) {
                return Material(
                  child: Container(
                    transform: Matrix4.identity()..scale(1.01, 1.05),
                    child: child,
                  ),
                );
              },
              header: header,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              children: _carrierCards,
              onReorder: (int oldIndex, int newIndex) {
                setState(() => handleCarriers(oldIndex, newIndex));
              },
            ),
          ));
    });
  }
}
