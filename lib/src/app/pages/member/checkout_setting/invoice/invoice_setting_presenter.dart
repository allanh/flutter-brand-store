import 'package:brandstores/src/domain/usecases/member/get_invoice_setting_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class InvoiceSettingPresenter extends Presenter {
  InvoiceSettingPresenter(repo)
      : getInvoiceSettingUseCase = GetInvoiceSettingUseCase(repo),
        submitDonationCodeUseCase = SubmitDonationCodeUseCase(repo);

  late Function getInvoiceSettingOnNext;
  late Function getInvoiceSettingOnComplete;
  late Function getInvoiceSettingOnError;

  final GetInvoiceSettingUseCase getInvoiceSettingUseCase;

  void getInvoiceSetting() {
    getInvoiceSettingUseCase.execute(
      _GetInvoiceSettingUseCaseObserver(this),
      GetInvoiceSettingUseCaseParams(),
    );
  }

  late Function submitDonationCodeOnNext;
  late Function submitDonationCodeOnComplete;
  late Function submitDonationCodeOnError;

  final SubmitDonationCodeUseCase submitDonationCodeUseCase;

  void submitDonationCode(code) {
    submitDonationCodeUseCase.execute(
      _SubmitDonationCodeCaseObserver(this),
      SubmitDonationCodeUseCaseParams(code),
    );
  }

  @override
  void dispose() {
    getInvoiceSettingUseCase.dispose();
    submitDonationCodeUseCase.dispose();
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
    presenter.getInvoiceSettingOnNext(response?.invoices);
  }
}

class _SubmitDonationCodeCaseObserver
    extends Observer<SubmitDonationCodeUseCaseResponse> {
  final InvoiceSettingPresenter presenter;
  _SubmitDonationCodeCaseObserver(this.presenter);

  @override
  void onComplete() {
    presenter.submitDonationCodeOnComplete();
  }

  @override
  void onError(e) {
    presenter.submitDonationCodeOnError(e);
  }

  @override
  void onNext(response) {
    presenter.submitDonationCodeOnNext(response);
  }
}
