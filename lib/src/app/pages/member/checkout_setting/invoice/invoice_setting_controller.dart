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

    invoiceInfoPresenter.submitCitizenDigitalCarrierOnNext = (bool isSuccess) {
      if (isSuccess) refreshUI();
    };

    invoiceInfoPresenter.submitCitizenDigitalCarrierOnComplete = () {
      debugPrint('Submit citizen digital code completed.');
    };

    invoiceInfoPresenter.submitCitizenDigitalCarrierOnError = (e) {
      debugPrint('Could not citizen digital code cause: $e');
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

  /// 取得發票列表
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

  /// 手機載具驗證規則
  /// 輸入八碼後驗證
  bool isValidMobileCarrier(String carrier) =>
      carrier.length < 8 ||
      carrier.startsWith(RegExp(r'^\/{1}[\d0-9A-Z.+-]{7}$')) ||
      carrier.isEmpty;

  /// 儲存手機載具
  void submitMobileCarrier(carrier) => invoiceInfoPresenter.submitMobileCarrier(
        _invoiceInfos?.mobileCarrier?.id,
        carrier,
      );

  /// 判斷是否有手機載具資料
  bool hasMobileCarrier() =>
      _invoiceInfos?.mobileCarrier?.id != null &&
      _invoiceInfos?.mobileCarrier?.carrierId != null;

  /// 設定手機載具為預設
  void handleMobileCarrierDefault() =>
      invoiceInfoPresenter.handleCarrierDefaultChange(
        CarrierType.mobileCarrier,
        id: _invoiceInfos?.mobileCarrier?.id,
        carrierId: _invoiceInfos?.mobileCarrier?.carrierId,
      );

  /// 設定會員載具為預設發票
  void handleMembershipCarrierDefault() => invoiceInfoPresenter
      .handleCarrierDefaultChange(CarrierType.membershipCarrier);

  /// 計算自然人憑證卡片高度
  double citizenDigitalCarrierCardHeight(bool isExpand) => isExpand
      ? 190.0 +
          (isValidCitizenDigitalCarrier(
                  _invoiceInfos!.citizenDigitalCarrier!.carrierId ?? '')
              ? 0.0
              : 30.0)
      : _invoiceInfos?.citizenDigitalCarrier?.carrierId != null &&
              _invoiceInfos!.citizenDigitalCarrier!.carrierId!.isNotEmpty
          ? 88.0
          : 56.0;

  /// 自然人憑證驗證
  bool isValidCitizenDigitalCarrier(String carrier) =>
      carrier.length < 16 ||
      carrier.startsWith(RegExp(r'^[A-Z]{2}[0-9]{14}$')) ||
      carrier.isEmpty;

  /// 判斷是否有自然人憑證資料
  bool hasCitizenDigitalCarrier() =>
      _invoiceInfos?.citizenDigitalCarrier?.id != null &&
      _invoiceInfos?.citizenDigitalCarrier?.carrierId != null;

  /// 儲存自然人憑證
  void submitCitizenDigitalCarrier(carrier) =>
      invoiceInfoPresenter.submitCitizenDigitalCarrier(
          invoiceInfos?.citizenDigitalCarrier?.id, carrier);

  /// 設定自然人憑證為預設發票
  void handleCitizenDigitalCarrierDefault() =>
      invoiceInfoPresenter.handleCarrierDefaultChange(
        CarrierType.citizenDigitalCarrier,
        id: _invoiceInfos?.citizenDigitalCarrier?.id,
        carrierId: _invoiceInfos?.citizenDigitalCarrier?.carrierId,
      );

  /// 檢查是否有三聯式電子發票載具資料
  bool hasValueAddedTaxCarrier() =>
      _invoiceInfos?.vatCarrier?.id != null &&
      _invoiceInfos?.vatCarrier?.carrierId != null &&
      _invoiceInfos?.vatCarrier?.title != null;

  /// 設定三聯式電子發票載具為預設發票
  void handleValueAddedTaxCarrierDefault() =>
      invoiceInfoPresenter.handleCarrierDefaultChange(
        CarrierType.valueAddedTaxCarrier,
        id: _invoiceInfos?.vatCarrier?.id,
        carrierId: _invoiceInfos?.vatCarrier?.carrierId,
        title: _invoiceInfos?.vatCarrier?.title,
      );

  /// 檢查是否有愛心碼資料
  bool hasDonationCode() =>
      _invoiceInfos?.donationNPO?.npoId != null &&
      _invoiceInfos?.donationNPO?.title != null;

  /// 設定愛心碼為預設發票
  void handleDonationCodeDefault() =>
      invoiceInfoPresenter.handleCarrierDefaultChange(
        CarrierType.donate,
        id: _invoiceInfos?.donationNPO?.id,
        carrierId: _invoiceInfos?.donationNPO?.npoId,
        title: _invoiceInfos?.donationNPO?.title,
      );
}
