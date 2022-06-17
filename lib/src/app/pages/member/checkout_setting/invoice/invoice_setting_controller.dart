import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../../data/repositories/member/data_invoice_setting_repository.dart';
import '../../../../../domain/entities/member/invoice.dart';
import 'invoice_setting_presenter.dart';

class InvoiceSettingController extends Controller {
  InvoiceSettingController(
      DataInvoiceSettingRepository dataInvoiceSettingRepository)
      : presenter = InvoiceSettingPresenter(dataInvoiceSettingRepository);

  final InvoiceSettingPresenter presenter;

  Invoices? _invoices;
  Invoices? get invoices => _invoices;

  @override
  void onInitState() {
    getInvoiceSetting();
  }

  @override
  void initListeners() {
    presenter.getInvoiceSettingOnNext = (Invoices invoices) {
      _invoices = invoices;
      refreshUI();
    };

    presenter.getInvoiceSettingOnComplete = () {
      debugPrint('Member invoice retrieved');
    };

    presenter.getInvoiceSettingOnError = (e) {
      debugPrint('Could not retrieve member invoice.');
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
    presenter.dispose();
    super.onDisposed();
  }

  void getInvoiceSetting() => presenter.getInvoiceSetting();
}
