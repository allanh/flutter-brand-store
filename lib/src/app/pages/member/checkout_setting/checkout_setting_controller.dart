import 'package:brandstores/src/data/repositories/member/data_shipping_address_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter/material.dart';

import '../../../../data/repositories/member/data_invoice_setting_repository.dart';
import '../../../../domain/entities/member/invoice.dart';
import '../../../../domain/entities/member/shipping_info.dart';

import 'invoice/invoice_setting_presenter.dart';
import 'shipping/shipping_address_presenter.dart';

class CheckoutSettingController extends Controller {
  CheckoutSettingController(
    DataShippingAddressRepository dataShippingInfoRepository,
    DataInvoiceSettingRepository dataInvoiceSettingRepository,
  )   : shippingAddressPresenter =
            ShippingAddressPresenter(dataShippingInfoRepository),
        invoiceInfoPresenter =
            InvoiceSettingPresenter(dataInvoiceSettingRepository);

  List<ShippingInfo>? _shippingInfos;
  List<ShippingInfo>? get shippingInfos => _shippingInfos;

  final ShippingAddressPresenter shippingAddressPresenter;

  InvoicesInfo? _invoiceInfos;
  InvoicesInfo? get invoiceInfos => _invoiceInfos;

  final InvoiceSettingPresenter invoiceInfoPresenter;

  @override
  void onInitState() {
    getShippingAddress();

    getInvoiceSetting();
  }

  @override
  void initListeners() {
    shippingAddressPresenter.getShippingAddressOnNext =
        (List<ShippingInfo> shippingInfos) {
      _shippingInfos = shippingInfos;
      refreshUI();
    };

    shippingAddressPresenter.getShippingAddressOnComplete = () {
      debugPrint('Shipping info retrieved');
    };

    shippingAddressPresenter.getShippingAddressOnError = (e) {
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
    shippingAddressPresenter.dispose();
    super.onDisposed();
  }

  @override
  void onResumed() => debugPrint('On resumed');

  @override
  void onReassembled() => debugPrint('View is about to be ressembled');

  @override
  void onDeactivated() => debugPrint('View is about to be deactivated');

  void getShippingAddress() => shippingAddressPresenter.getShippingAddress();

  void getInvoiceSetting() => invoiceInfoPresenter.getInvoiceSetting();
}
