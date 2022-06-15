import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../../data/repositories/member/data_invoice_setting_repository.dart';
import 'invoice_setting_presenter.dart';

class InvoiceSettingController extends Controller {
  InvoiceSettingController(
      DataInvoiceSettingRepository dataInvoiceSettingRepository)
      : presenter = InvoiceSettingPresenter(dataInvoiceSettingRepository);

  final InvoiceSettingPresenter presenter;

  @override
  void onInitState() {}

  @override
  void initListeners() {}

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
}
