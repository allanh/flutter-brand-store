import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:brandstores/src/domain/entities/member/invoice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:go_router/go_router.dart';

import '../../../../../data/repositories/member/data_invoice_setting_repository.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/member/dialog_wrapper.dart';
import '../../../../widgets/member/checkout_setting/reorderable_card.dart';
import '../../../../widgets/member/checkout_setting/citizen_digital_carrier.dart';
import '../../../../widgets/member/checkout_setting/donation_invoice_carrier.dart';
import '../../../../widgets/member/checkout_setting/membership_carrier.dart';
import '../../../../widgets/member/checkout_setting/mobile_carrier.dart';
import '../../../../widgets/member/checkout_setting/value_added_tax_carrier.dart';
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
  bool _isExpandedMobileCarrier = false;
  bool _isExpandedCitizenDigitalCertificateCarrier = false;
  bool _isExpandedValueAddedTaxCarrier = false;
  bool _isExpandedDonationInvoice = false;

  List<CarrierType> invoiceTypes = [
    CarrierType.membershipCarrier,
    CarrierType.mobileCarrier,
    CarrierType.citizenDigitalCarrier,
    CarrierType.valueAddedTaxCarrier,
    CarrierType.donate,
  ];

  @override
  Widget get view {
    return ControlledWidgetBuilder<InvoiceSettingController>(
        builder: (context, controller) {
      String? _membershipCarrier =
          controller.invoiceInfos?.membershipCarrier?.memberId.toString();
      String? _mobileCarrier =
          controller.invoiceInfos?.mobileCarrier?.carrierId?.toString();
      String? _citizenDigitalCarrier =
          controller.invoiceInfos?.citizenDigitalCarrier?.carrierId?.toString();
      String? _valueAddedTaxId =
          controller.invoiceInfos?.vatCarrier?.carrierId?.toString();
      String? _valueAddedTaxTitle = controller.invoiceInfos?.vatCarrier?.title;

      /// ??????????????????/??????
      void handleCarrierExpand(CarrierType type, bool isExpand) {
        setState(() {
          switch (type) {
            case CarrierType.membershipCarrier:
              break;
            case CarrierType.mobileCarrier:
              _isExpandedMobileCarrier = isExpand;
              break;
            case CarrierType.citizenDigitalCarrier:
              _isExpandedCitizenDigitalCertificateCarrier = isExpand;
              break;
            case CarrierType.valueAddedTaxCarrier:
              _isExpandedValueAddedTaxCarrier = isExpand;
              break;
            case CarrierType.donate:
              _isExpandedDonationInvoice = isExpand;
              break;
          }
        });
      }

      /// ??????????????????????????????
      if (controller.invoiceInfos?.mobileCarrier?.isDefault ?? false) {
        invoiceTypes
            .removeWhere((element) => element == CarrierType.mobileCarrier);
        invoiceTypes.insert(0, CarrierType.mobileCarrier);
      } else if (controller.invoiceInfos?.citizenDigitalCarrier?.isDefault ??
          false) {
        invoiceTypes.removeWhere(
            (element) => element == CarrierType.citizenDigitalCarrier);
        invoiceTypes.insert(0, CarrierType.citizenDigitalCarrier);
      } else if (controller.invoiceInfos?.vatCarrier?.isDefault ?? false) {
        invoiceTypes.removeWhere(
            (element) => element == CarrierType.valueAddedTaxCarrier);
        invoiceTypes.insert(0, CarrierType.valueAddedTaxCarrier);
      } else if (controller.invoiceInfos?.donationNPO?.isDefault ?? false) {
        invoiceTypes.removeWhere((element) => element == CarrierType.donate);
        invoiceTypes.insert(0, CarrierType.donate);
      }

      /// ??????????????????
      void handleDefaultCarrier(CarrierType type) {
        /// ????????????????????????????????????
        controller.invoiceInfos?.membershipCarrier?.isDefault =
            type == CarrierType.membershipCarrier;
        controller.invoiceInfos?.mobileCarrier?.isDefault =
            type == CarrierType.mobileCarrier;
        controller.invoiceInfos?.citizenDigitalCarrier?.isDefault =
            type == CarrierType.citizenDigitalCarrier;
        controller.invoiceInfos?.vatCarrier?.isDefault =
            type == CarrierType.valueAddedTaxCarrier;
        controller.invoiceInfos?.donationNPO?.isDefault =
            type == CarrierType.donate;

        switch (type) {
          case CarrierType.membershipCarrier:
            controller.handleMembershipCarrierDefault();
            break;
          case CarrierType.mobileCarrier:
            if (controller.hasMobileCarrier()) {
              controller.handleMobileCarrierDefault();
            }
            break;
          case CarrierType.citizenDigitalCarrier:
            if (controller.hasCitizenDigitalCarrier()) {
              controller.handleCitizenDigitalCarrierDefault();
            }
            break;
          case CarrierType.valueAddedTaxCarrier:
            if (controller.hasValueAddedTaxCarrier()) {
              controller.handleValueAddedTaxCarrierDefault();
            }
            break;
          case CarrierType.donate:
            if (controller.hasDonationCode()) {
              controller.handleDonationCodeDefault();
            }
            break;
        }
      }

      /// ????????????
      void handleMembershipCarrierRegister() {
        DialogWrapper().showTwoButtonsDialog(
            context: context,
            title: '??????????????????',
            content:
                '?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????',
            contentPadding:
                const EdgeInsets.only(left: 24.0, right: 24.0, top: 24.0),
            textAlign: TextAlign.justify,
            handleCancel: () => Navigator.pop(context, '??????'),
            handleSubmit: () {
              Navigator.pop(context, '??????');
              context.pushNamed(carrierRegisterWebRouteName);
            });
      }

      /// ??????????????????
      void handleSubmitMobileCarrier(String carrier) {
        controller.submitMobileCarrier(carrier);
      }

      /// ????????????????????????
      void handleMobileCarrierChange(String text) {
        setState(() {
          _mobileCarrier = text;
          controller.invoiceInfos?.mobileCarrier?.carrierId = _mobileCarrier;
        });
      }

      /// ???????????????????????????
      void handleSubmitCitizenDigitalCertificateCarrier(String code) {
        controller.submitCitizenDigitalCarrier(code);
      }

      /// ???????????????????????????
      void handleCitizenDigitalCarrierChange(String text) {
        setState(() {
          _citizenDigitalCarrier = text;
          controller.invoiceInfos?.citizenDigitalCarrier?.carrierId =
              _citizenDigitalCarrier;
        });
      }

      /// ????????????????????????
      void handleSubmitValueAddedTaxCarrier(String code, String title) {
        controller.submitValueAddedTax(code, title);
      }

      void handleVatIdChange(id) {
        setState(() {
          _valueAddedTaxId = id;
          controller.invoiceInfos?.vatCarrier?.carrierId = id;
          controller.isValidVatId(id);
        });
      }

      void handleTitleChange(title) {
        setState(() {
          _valueAddedTaxTitle = title;
          controller.invoiceInfos?.vatCarrier?.title = title;
          controller.isValidVatTitle(title);
        });
      }

      /// ?????????????????????
      void handleSubmitDonationCode(String code) {
        debugPrint(code);
        controller.submitDonationCode(code);
      }

      /// ?????????????????????????????????
      void handleOpenDonationCodeWeb() {
        context.pushNamed(donationCodeWebRouteName);
      }

      /// ????????????
      List<ReorderableCard> _buildReorderableCards(
          List<CarrierType> invoiceTypes) {
        return List.generate(invoiceTypes.length, (index) {
          switch (invoiceTypes[index]) {

            /// ????????????
            case CarrierType.membershipCarrier:
              return ReorderableCard(
                  key: ValueKey(index),
                  item: MembershipCarrierInfo(
                      isDefault: index == 0,
                      id: _membershipCarrier,
                      handleMembershipCarrierRegister: () =>
                          handleMembershipCarrierRegister()),
                  height: index == 0 ? 130.0 : 100.0,
                  isSelected: index == 0);

            /// ??????-??????????????????
            case CarrierType.mobileCarrier:
              return ReorderableCard(
                  key: ValueKey(index),
                  item: MobileCarrierInfo(
                    isDefault: index == 0,
                    isExpand: _isExpandedMobileCarrier,
                    isValid:
                        controller.isValidMobileCarrier(_mobileCarrier ?? ''),
                    code: _mobileCarrier,
                    handleEapand: () => handleCarrierExpand(
                      CarrierType.mobileCarrier,
                      !_isExpandedMobileCarrier,
                    ),
                    handleSubmit: (code) => handleSubmitMobileCarrier(code),
                    handleCarrierChange: (text) =>
                        handleMobileCarrierChange(text),
                  ),
                  height: controller
                      .mobileCarrierCardHeight(_isExpandedMobileCarrier),
                  isSelected: index == 0);

            /// ??????-???????????????
            case CarrierType.citizenDigitalCarrier:
              return ReorderableCard(
                  key: ValueKey(index),
                  item: CitizenDigitalCarrierInfo(
                    isDefault: index == 0,
                    isExpand: _isExpandedCitizenDigitalCertificateCarrier,
                    isValid: controller.isValidCitizenDigitalCarrier(
                        _citizenDigitalCarrier ?? ''),
                    code: _citizenDigitalCarrier,
                    handleExpand: () => handleCarrierExpand(
                      CarrierType.citizenDigitalCarrier,
                      !_isExpandedCitizenDigitalCertificateCarrier,
                    ),
                    handleSubmit: (code) =>
                        handleSubmitCitizenDigitalCertificateCarrier(code),
                    handleCarrierChange: (text) =>
                        handleCitizenDigitalCarrierChange(text),
                  ),
                  height: controller.citizenDigitalCarrierCardHeight(
                      _isExpandedCitizenDigitalCertificateCarrier),
                  isSelected: index == 0);

            /// ??????-?????????????????????
            case CarrierType.valueAddedTaxCarrier:
              return ReorderableCard(
                  key: ValueKey(index),
                  item: ValueAddedTaxCarrierInfo(
                    isDefault: index == 0,
                    isExpand: _isExpandedValueAddedTaxCarrier,
                    code: _valueAddedTaxId,
                    title: _valueAddedTaxTitle,
                    isValidId: controller.isValidVatId(_valueAddedTaxId ?? ''),
                    isValidTitle:
                        controller.isValidVatTitle(_valueAddedTaxTitle ?? ''),
                    handleExpand: () => handleCarrierExpand(
                      CarrierType.valueAddedTaxCarrier,
                      !_isExpandedValueAddedTaxCarrier,
                    ),
                    handleSubmit: (code, title) =>
                        handleSubmitValueAddedTaxCarrier(code, title),
                    handleIdChange: (id) => handleVatIdChange(id),
                    handleTitleChange: (title) => handleTitleChange(title),
                  ),
                  height: controller
                      .valueAddedTaxCardHeight(_isExpandedValueAddedTaxCarrier),
                  isSelected: index == 0);

            /// ????????????
            case CarrierType.donate:
              int npoLength =
                  controller.invoiceInfos?.donationNPO?.npos?.length ?? 0;
              bool hasDefault = false;
              if (controller.invoiceInfos?.donationNPO?.npos != null) {
                hasDefault = controller.invoiceInfos?.donationNPO?.npos!
                        .where((npo) => npo.isEnabled)
                        .toList()
                        .isNotEmpty ??
                    hasDefault;
              }

              return ReorderableCard(
                  key: ValueKey(index),
                  item: DonationInvoiceCarrier(
                    isDefault: index == 0,
                    isExpand: _isExpandedDonationInvoice,
                    npos: controller.invoiceInfos?.donationNPO?.npos,
                    handleExpand: () => handleCarrierExpand(
                      CarrierType.donate,
                      !_isExpandedDonationInvoice,
                    ),
                    handleSubmit: handleSubmitDonationCode,
                    handleOpenDonationCodeWeb: () =>
                        handleOpenDonationCodeWeb(),
                  ),
                  height: _isExpandedDonationInvoice
                      ? (230.0 + 20.0 * npoLength)
                      : hasDefault
                          ? 88.0
                          : 56.0,
                  isSelected: index == 0);
          }
        });
      }

      List<ReorderableCard> _carrierCards =
          _buildReorderableCards(invoiceTypes);

      void handleCarriers(int oldIndex, int newIndex) {
        /// ?????? index ???????????? out of bounds
        if (oldIndex < newIndex) {
          newIndex -= 1;
        }

        /// ????????????????????????
        CarrierType _type = invoiceTypes.removeAt(oldIndex);

        /// ??????????????????????????????????????????
        invoiceTypes.insert(newIndex, _type);

        handleDefaultCarrier(invoiceTypes.first);

        /// ???????????????????????????????????????
        _carrierCards = _buildReorderableCards(invoiceTypes);
      }

      Widget header = Builder(builder: (context) {
        return Column(
          children: [
            const SizedBox(height: 12.0),
            Text('???????????????????????????????????????????????????????????????????????????????????????',
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
                  '??????????????????',
                  style: Theme.of(context).textTheme.bodyLarge,
                )
              ],
            ),
            const SizedBox(height: 12.0),
          ],
        );
      });

      return Scaffold(
          appBar: AppBar(title: const Text('????????????')),
          body: Padding(
            padding: const EdgeInsets.only(bottom: 44.0),
            child: ReorderableListView(
              proxyDecorator: (child, index, animation) {
                /// ?????????????????????????????????????????????????????????
                return Material(
                  child: Container(
                    transform: Matrix4.identity()..scale(1.01, 1.05),
                    child: ReorderableCard(
                      isSelected: true,
                      height: _carrierCards[index].height,
                      item: _carrierCards[index].item,
                      isDragging: true,
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
