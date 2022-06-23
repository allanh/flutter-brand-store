import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../../data/repositories/member/data_invoice_setting_repository.dart';
import '../../../../../domain/entities/member/invoice.dart';
import 'invoice_setting_presenter.dart';

class InvoiceSettingController extends Controller {
  InvoiceSettingController(
      DataInvoiceSettingRepository dataInvoiceSettingRepository)
      : invoiceInfoPresenter =
            InvoiceSettingPresenter(dataInvoiceSettingRepository);

  final InvoiceSettingPresenter invoiceInfoPresenter;

  InvoicesInfo? _invoiceInfos;
  InvoicesInfo? get invoiceInfos => _invoiceInfos;

  @override
  void onInitState() {
    getInvoiceSetting();
  }

  @override
  void initListeners() {
    invoiceInfoPresenter.getInvoiceSettingOnNext = (InvoicesInfo invoices) {
      _invoiceInfos = invoices;
      refreshUI();
    };

    invoiceInfoPresenter.getInvoiceSettingOnComplete = () {
      debugPrint('Member invoice retrieved');
    };

    invoiceInfoPresenter.getInvoiceSettingOnError = (e) {
      debugPrint('Could not retrieve member invoice.');
    };

    invoiceInfoPresenter.submitDonationCodeOnNext = () {
      refreshUI();
    };

    invoiceInfoPresenter.submitDonationCodeOnComplete = () {
      debugPrint('Submit donation code completed.');
    };

    invoiceInfoPresenter.submitDonationCodeOnError = (e) {
      debugPrint('Could not submit donation code cause: $e');
    };

    invoiceInfoPresenter.submitMobileCarrierOnNext = (bool isSuccess) {
      if (isSuccess) refreshUI();
    };

    invoiceInfoPresenter.submitMobileCarrierOnComplete = () {
      debugPrint('Submit donation code completed.');
    };

    invoiceInfoPresenter.submitMobileCarrierOnError = (e) {
      debugPrint('Could not submit donation code cause: $e');
    };

    invoiceInfoPresenter.changeDefaultCarrierOnNext = (bool isSuccess) {
      if (isSuccess) refreshUI();
    };

    invoiceInfoPresenter.changeDefaultCarrierOnComplete = () {
      debugPrint('Submit donation code completed.');
    };

    invoiceInfoPresenter.changeDefaultCarrierOnError = (e) {
      debugPrint('Could not submit donation code cause: $e');
    };
  }

  @override
  void onResumed() => debugPrint('On resumed');

  @override
  void onReassembled() => debugPrint('View is about to be ressembled');

  @override
  void onDeactivated() => debugPrint('View is about to be deactivated');

  @override
  void onDisposed() {
    // don't forget to dispose of the presenter
    invoiceInfoPresenter.dispose();
    super.onDisposed();
  }

  void getInvoiceSetting() => invoiceInfoPresenter.getInvoiceSetting();

  /// 常用發票新增愛心捐贈
  void submitDonationCode(code) =>
      invoiceInfoPresenter.submitDonationCode(code);

  /// 計算手機載具卡片需要高度
  double mobileCarrierCardHeight(
    bool isExpand,
  ) =>
      isExpand
          ? 171.0 +
              (isValidMobileCarrier(
                      _invoiceInfos!.mobileCarrier!.carrierId ?? '')
                  ? 0.0
                  : 30.0)
          : _invoiceInfos?.mobileCarrier?.carrierId != null &&
                  _invoiceInfos!.mobileCarrier!.carrierId!.isNotEmpty
              ? 88.0
              : 56.0;

  bool isValidMobileCarrier(String carrier) =>
      carrier.length < 8 ||
      carrier.startsWith(RegExp(r'^\/{1}[\d0-9A-Z.+-]{7}$')) ||
      carrier.isEmpty;

  void submitMobileCarrier(carrier) => invoiceInfoPresenter.submitMobileCarrier(
        _invoiceInfos?.mobileCarrier?.id,
        carrier,
      );

  bool hasMobileCarrier() =>
      _invoiceInfos?.mobileCarrier?.id != null &&
      _invoiceInfos?.mobileCarrier?.carrierId != null;

  void handleMobileCarrierDefault() =>
      invoiceInfoPresenter.handleCarrierDefaultChange(
        CarrierType.mobileCarrier,
        id: _invoiceInfos?.mobileCarrier?.id,
        carrierId: _invoiceInfos?.mobileCarrier?.carrierId,
      );

  void handleMembershipCarrierDefault() => invoiceInfoPresenter
      .handleCarrierDefaultChange(CarrierType.membershipCarrier);

  bool hasCitizenDigitalCarrier() =>
      _invoiceInfos?.citizenDigitalCarrier?.id != null &&
      _invoiceInfos?.citizenDigitalCarrier?.carrierId != null;

  void handleCitizenDigitalCarrierDefault() =>
      invoiceInfoPresenter.handleCarrierDefaultChange(
        CarrierType.citizenDigitalCarrier,
        id: _invoiceInfos?.citizenDigitalCarrier?.id,
        carrierId: _invoiceInfos?.citizenDigitalCarrier?.carrierId,
      );

  bool hasValueAddedTaxCarrier() =>
      _invoiceInfos?.vatCarrier?.id != null &&
      _invoiceInfos?.vatCarrier?.carrierId != null &&
      _invoiceInfos?.vatCarrier?.title != null;

  void handleValueAddedTaxCarrierDefault() =>
      invoiceInfoPresenter.handleCarrierDefaultChange(
        CarrierType.valueAddedTaxCarrier,
        id: _invoiceInfos?.vatCarrier?.id,
        carrierId: _invoiceInfos?.vatCarrier?.carrierId,
        title: _invoiceInfos?.vatCarrier?.title,
      );

  bool hasDonationCode() =>
      _invoiceInfos?.donationNPO?.npoId != null &&
      _invoiceInfos?.donationNPO?.title != null;

  void handleDonationCodeDefault() =>
      invoiceInfoPresenter.handleCarrierDefaultChange(
        CarrierType.donate,
        id: _invoiceInfos?.donationNPO?.id,
        carrierId: _invoiceInfos?.donationNPO?.npoId,
        title: _invoiceInfos?.donationNPO?.title,
      );
}
