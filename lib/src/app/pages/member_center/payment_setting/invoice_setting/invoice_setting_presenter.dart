import 'package:brandstores/src/domain/usecases/member_center/get_invoice_setting_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class InvoiceSettingPresenter extends Presenter {
  InvoiceSettingPresenter(repo)
      : getInvoiceSettingUseCase = GetInvoiceSettingUseCase(repo);

  late Function getInvoiceSettingOnNext;
  late Function getInvoiceSettingOnComplete;
  late Function getInvoiceSettingOnError;

  final GetInvoiceSettingUseCase getInvoiceSettingUseCase;

  void getInvoiceSetting() {
    getInvoiceSettingUseCase.execute(_GetInvoiceSettingUseCaseObserver(this),
        GetInvoiceSettingUseCaseParams());
  }

  @override
  void dispose() {
    getInvoiceSettingUseCase.dispose();
  }
}

class _GetInvoiceSettingUseCaseObserver
    extends Observer<GetInvoiceSettingUseCaseResponse> {
  final InvoiceSettingPresenter presenter;

  _GetInvoiceSettingUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    presenter.getInvoiceSettingOnComplete();
  }

  @override
  void onError(e) {
    presenter.getInvoiceSettingOnError(e);
  }

  @override
  void onNext(response) {
    presenter.getInvoiceSettingOnNext(response);
  }
}
