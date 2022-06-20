import 'package:brandstores/src/data/repositories/member/data_shipping_info_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter/material.dart';

import '../../../../data/repositories/member/data_invoice_setting_repository.dart';
import '../../../../domain/entities/member/invoice.dart';
import '../../../../domain/entities/member/shipping_info.dart';
import 'checkout_setting_presenter.dart';
import 'invoice/invoice_setting_presenter.dart';

class CheckoutSettingController extends Controller {
  CheckoutSettingController(
    DataShippingInfoRepository dataShippingInfoRepository,
    DataInvoiceSettingRepository dataInvoiceSettingRepository,
  )   : shippingInfoPresenter =
            ShippingInfoPresenter(dataShippingInfoRepository),
        invoiceInfoPresenter =
            InvoiceSettingPresenter(dataInvoiceSettingRepository);

  final ShippingInfoPresenter shippingInfoPresenter;

  List<ShippingInfo>? _shippingInfos;
  List<ShippingInfo>? get shippingInfos => _shippingInfos;

  InvoicesInfo? _invoiceInfos;
  InvoicesInfo? get invoiceInfos => _invoiceInfos;

  final InvoiceSettingPresenter invoiceInfoPresenter;

  @override
  void onInitState() {
    getShippingInfo();

    getInvoiceSetting();
  }

  @override
  void initListeners() {
    shippingInfoPresenter.getShippingInfoOnNext =
        (List<ShippingInfo> shippingInfos) {
      _shippingInfos = shippingInfos;
      refreshUI();
    };

    shippingInfoPresenter.getShippingInfoOnComplete = () {
      debugPrint('Shipping info retrieved');
    };

    shippingInfoPresenter.getShippingInfoOnError = (e) {
      debugPrint('Could not retrieve shipping info.');
    };

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
  }

  @override
  void onDisposed() {
    // don't forget to dispose of the presenter
    invoiceInfoPresenter.dispose();
    shippingInfoPresenter.dispose();
    super.onDisposed();
  }

  @override
  void onResumed() => debugPrint('On resumed');

  @override
  void onReassembled() => debugPrint('View is about to be ressembled');

  @override
  void onDeactivated() => debugPrint('View is about to be deactivated');

  void getShippingInfo() => shippingInfoPresenter.getShippingInfo();

  void getInvoiceSetting() => invoiceInfoPresenter.getInvoiceSetting();
}
