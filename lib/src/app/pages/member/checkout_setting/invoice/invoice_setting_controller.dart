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

    invoiceInfoPresenter.submitDonationCodeOnNext = (bool isSuccess) {
      if (isSuccess) refreshUI();
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
  void submitDonationCode(code) => invoiceInfoPresenter.submitDonationCode(
      _invoiceInfos?.donationNPO?.id, code);

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

  /// 統一編號驗證
  bool isValidVatId(String vatId) {
    /// 一、營利事業統一編號（下稱統一編號）供營利事業及扣繳單位配號使用，預估空號將於113年用罄。
    /// 二、為擴增統一編號號碼並與現行配賦之統一編號相容（新舊統一編號格式相同），後續請公私部門配合修改統一編號檢核程式，主要係修正「檢查邏輯由可被『10』整除改為可被『5』整除」，相關說明詳如附件。
    /// 三、全國公私部門倘有使用統一編號檢核程式，請於112年3月31日前完成統一編號檢核程式修改作業，相關系統文件請併同檢視修正。
    /// 四、預計112年4月以後，將視舊號餘存狀況逐步釋出新產製之統一編號。
    /// https://www.fia.gov.tw/singlehtml/3?cntId=c4d9cff38c8642ef8872774ee9987283
    const divided = 10;

    /// 邏輯乘數
    final List<int> logicMultipliers = <int>[1, 2, 1, 2, 1, 2, 4, 1];

    int total = 0;

    final chars = vatId.characters.toList();

    /// 將十位數與個位數相加，如果相加之和大於 10，則繼續相加，反之，回傳和
    int recursive(value) {
      int result = (value ~/ 10) + (value % 10);
      if (result > 9) {
        return recursive(result);
      }
      return result;
    }

    for (int i = 0; i < chars.length; i++) {
      int value = int.parse(chars[i]) * logicMultipliers[i];

      total += value < 10 ? value : recursive(value);
    }
    debugPrint('origin total: $total');

    /// 倒數第二位為 7 時，乘積之和最後第二位數取 0，或 1 均可，其中之一「和」
    /// 能被 10 整除則符合邏輯。
    if (chars.length > 7 && chars[6] == '7') {
      if ((total - 1) % divided == 0) {
        total -= 1;
      } else if ((total + 1) % divided == 0) {
        total += 1;
      }
    }
    if (chars.length == 8) {
      debugPrint(
          '$vatId is equal [$total], which ${total % divided == 0 ? 'can' : 'can not'} divided by $divided then it\'s a ${total % divided == 0 ? 'valid' : 'invalid'} id');
    }
    return total % divided == 0;
  }

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
