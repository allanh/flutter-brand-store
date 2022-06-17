import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../../data/repositories/member/data_invoice_setting_repository.dart';
import '../../../../widgets/member/checkout_setting/reorderable_card.dart';
import '../../../../widgets/member/checkout_setting/citizen_digital_carrier.dart';
import '../../../../widgets/member/checkout_setting/donation_invoice_carrier.dart';
import '../../../../widgets/member/checkout_setting/member_account_carrier.dart';
import '../../../../widgets/member/checkout_setting/mobile_carrier.dart';
import '../../../../widgets/member/checkout_setting/value_added_tax_carrier.dart';
import 'invoice_setting_controller.dart';

enum InvoiceType {
  memberAccountCarrier,
  mobileCarrier,
  citizenDigitalCertificateCarrier,
  valueAddedTaxCarrier,
  donationInvoice,
}

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
  bool _isExpandedMobileCarrier = false;
  bool _isExpandedCitizenDigitalCertificateCarrier = false;
  bool _isExpandedValueAddedTaxCarrier = false;
  bool _isExpandedDonationInvoice = false;

  List<InvoiceType> invoiceTypes = [
    InvoiceType.memberAccountCarrier,
    InvoiceType.mobileCarrier,
    InvoiceType.citizenDigitalCertificateCarrier,
    InvoiceType.valueAddedTaxCarrier,
    InvoiceType.donationInvoice,
  ];

  @override
  Widget get view {
    return ControlledWidgetBuilder<InvoiceSettingController>(
        builder: (context, controller) {
      String? _membershipCarrier =
          controller.invoices?.membershipCarrier?.carrierId.toString();
      String? _mobileCarrier =
          controller.invoices?.mobileCarrier?.carrierId?.toString();
      String? _citizenDigitalCarrier =
          controller.invoices?.citizenDigitalCarrier?.carrierId?.toString();
      String? _valueAddedTaxId =
          controller.invoices?.vatCarrier?.vatId?.toString();
      String? _valueAddedTaxTitle = controller.invoices?.vatCarrier?.title;

      void handleCarrierExpand(InvoiceType type, bool isExpand) {
        setState(() {
          switch (type) {
            case InvoiceType.memberAccountCarrier:
              break;
            case InvoiceType.mobileCarrier:
              _isExpandedMobileCarrier = isExpand;
              break;
            case InvoiceType.citizenDigitalCertificateCarrier:
              _isExpandedCitizenDigitalCertificateCarrier = isExpand;
              break;
            case InvoiceType.valueAddedTaxCarrier:
              _isExpandedValueAddedTaxCarrier = isExpand;
              break;
            case InvoiceType.donationInvoice:
              _isExpandedDonationInvoice = isExpand;
              break;
          }
        });
      }

      void handleCollapse(InvoiceType type) {
        handleCarrierExpand(type, false);
      }

      void handleExpand(InvoiceType type) {
        handleCarrierExpand(type, true);
      }

      void handleSubmitMobileCarrier(String code) {}

      void handleSubmitCitizenDigitalCertificateCarrier(String code) {}

      void handleSubmitValueAddedTaxCarrier(String code, String title) {}

      void handleSubmitNPO(npo) {
        controller.invoices?.donationNPO?.npos?.forEach((element) {
          element.isEnabled = element.npoId == npo.npoId;
        });
      }

      List<ReorderableCard> _buildReorderableCards(
          List<InvoiceType> invoiceTypes) {
        return List.generate(invoiceTypes.length, (index) {
          switch (invoiceTypes[index]) {

            /// 會員載具
            case InvoiceType.memberAccountCarrier:
              return ReorderableCard(
                  key: ValueKey(index),
                  item: MemberAccountCarrier(
                    isDefault: index == 0,
                    id: _membershipCarrier,
                  ),
                  height: 120.0,
                  isSelected: index == 0);

            /// 個人-手機條碼載具
            case InvoiceType.mobileCarrier:
              return ReorderableCard(
                  key: ValueKey(index),
                  item: MobileCarrier(
                    isDefault: index == 0,
                    isExpand: _isExpandedMobileCarrier,
                    code: _mobileCarrier,
                    handleCollapse: () =>
                        handleCollapse(InvoiceType.mobileCarrier),
                    handleEapand: () => handleExpand(InvoiceType.mobileCarrier),
                    handleSubmit: (code) => handleSubmitMobileCarrier,
                  ),
                  height: _isExpandedMobileCarrier
                      ? 171.0
                      : _mobileCarrier != null && _mobileCarrier.isNotEmpty
                          ? 88.0
                          : 56.0,
                  isSelected: index == 0);

            /// 個人-自然人憑證
            case InvoiceType.citizenDigitalCertificateCarrier:
              return ReorderableCard(
                  key: ValueKey(index),
                  item: CitizenDigitalCarrier(
                    isDefault: index == 0,
                    isExpand: _isExpandedCitizenDigitalCertificateCarrier,
                    code: _citizenDigitalCarrier,
                    handleCollapse: () => handleCollapse(
                        InvoiceType.citizenDigitalCertificateCarrier),
                    handleExpand: () => handleExpand(
                        InvoiceType.citizenDigitalCertificateCarrier),
                    handleSubmit: (code) =>
                        handleSubmitCitizenDigitalCertificateCarrier,
                  ),
                  height: _isExpandedCitizenDigitalCertificateCarrier
                      ? 190.0
                      : _citizenDigitalCarrier != null &&
                              _citizenDigitalCarrier.isNotEmpty
                          ? 88.0
                          : 56.0,
                  isSelected: index == 0);

            /// 公司-三聯式電子發票
            case InvoiceType.valueAddedTaxCarrier:
              return ReorderableCard(
                  key: ValueKey(index),
                  item: ValueAddedTaxCarrier(
                    isDefault: index == 0,
                    isExpand: _isExpandedValueAddedTaxCarrier,
                    code: _valueAddedTaxId,
                    title: _valueAddedTaxTitle,
                    handleCollapse: () =>
                        handleCollapse(InvoiceType.valueAddedTaxCarrier),
                    handleExpand: () =>
                        handleExpand(InvoiceType.valueAddedTaxCarrier),
                    handleSubmit: (code, title) =>
                        handleSubmitValueAddedTaxCarrier,
                  ),
                  height: _isExpandedValueAddedTaxCarrier
                      ? 305.0
                      : _valueAddedTaxId != null &&
                              _valueAddedTaxId.isNotEmpty &&
                              _valueAddedTaxTitle != null &&
                              _valueAddedTaxTitle.isNotEmpty
                          ? 88.0
                          : 56.0,
                  isSelected: index == 0);

            /// 捐贈發票
            case InvoiceType.donationInvoice:
              int npoLength =
                  controller.invoices?.donationNPO?.npos?.length ?? 0;
              return ReorderableCard(
                  key: ValueKey(index),
                  item: DonationInvoiceCarrier(
                    isDefault: index == 0,
                    isExpand: _isExpandedDonationInvoice,
                    npos: controller.invoices?.donationNPO?.npos,
                    handleCollpase: () =>
                        handleCollapse(InvoiceType.donationInvoice),
                    handleExpand: () =>
                        handleExpand(InvoiceType.donationInvoice),
                    handleSubmit: handleSubmitNPO,
                  ),
                  height: _isExpandedDonationInvoice
                      ? (314.0 + 20.0 * npoLength)
                      : 56.0,
                  isSelected: index == 0);
          }
        });
      }

      List<ReorderableCard> _carrierCards =
          _buildReorderableCards(invoiceTypes);

      void handleCarriers(int oldIndex, int newIndex) {
        /// 調整 index 避免發生 out of bounds
        if (oldIndex < newIndex) {
          newIndex -= 1;
        }

        /// 取出被拖移的載具
        InvoiceType _type = invoiceTypes.removeAt(oldIndex);

        /// 根據新的位置插入被拖移的載具
        invoiceTypes.insert(newIndex, _type);

        /// 根據重新排列的載具製作卡片
        _carrierCards = _buildReorderableCards(invoiceTypes);
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
                Text(
                  '預設發票設定',
                  style: Theme.of(context).textTheme.bodyLarge,
                )
              ],
            ),
            const SizedBox(height: 12.0),
          ],
        );
      });

      return Scaffold(
          appBar: AppBar(title: const Text('發票設定')),
          body: Padding(
            padding: const EdgeInsets.only(bottom: 44.0),
            child: ReorderableListView(
              proxyDecorator: (child, index, animation) {
                /// 將卡片放大並且設定選擇狀態，讓邊框變色
                return Material(
                  child: Container(
                    transform: Matrix4.identity()..scale(1.01, 1.05),
                    child: ReorderableCard(
                      isSelected: true,
                      height: _carrierCards[index].height,
                      item: _carrierCards[index].item,
                    ),
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
