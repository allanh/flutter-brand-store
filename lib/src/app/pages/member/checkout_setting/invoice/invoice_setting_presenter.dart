import 'package:brandstores/src/domain/usecases/member/get_invoice_setting_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class InvoiceSettingPresenter extends Presenter {
  InvoiceSettingPresenter(repo)
      : getInvoiceSettingUseCase = GetInvoiceSettingUseCase(repo),
        submitDonationCodeUseCase = SubmitDonationCodeUseCase(repo),
        submitMobileCarrierUseCase = SubmitMobileCarrierUseCase(repo),
        changeDefaultCarrierUseCase = ChangeDefaultCarrierUseCase(repo),
        submitCitizenDigitalCarrierUseCase =
            SubmitCitizenDigitalCarrierUseCase(repo);

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
      _SubmitDonationCodeUseCaseObserver(this),
      SubmitDonationCodeUseCaseParams(code),
    );
  }

  late Function submitMobileCarrierOnNext;
  late Function submitMobileCarrierOnComplete;
  late Function submitMobileCarrierOnError;

  final SubmitMobileCarrierUseCase submitMobileCarrierUseCase;

  void submitMobileCarrier(id, carrier) {
    submitMobileCarrierUseCase.execute(
      _SubmitMobileCarrierUseCaseObserver(this),
      SubmitMobileCarrierUseCaseParams(id, carrier),
    );
  }

  late Function submitCitizenDigitalCarrierOnNext;
  late Function submitCitizenDigitalCarrierOnComplete;
  late Function submitCitizenDigitalCarrierOnError;

  final SubmitCitizenDigitalCarrierUseCase submitCitizenDigitalCarrierUseCase;

  void submitCitizenDigitalCarrier(id, carrier) {
    submitCitizenDigitalCarrierUseCase.execute(
      _SubmitCitizenDigitalCarrierUseCaseObserver(this),
      SubmitCitizenDigitalCarrierUseCaseParams(id, carrier),
    );
  }

  late Function changeDefaultCarrierOnNext;
  late Function changeDefaultCarrierOnComplete;
  late Function changeDefaultCarrierOnError;

  final ChangeDefaultCarrierUseCase changeDefaultCarrierUseCase;

  void handleCarrierDefaultChange(type,
      {String? id = '', String? carrierId = '', String? title}) {
    changeDefaultCarrierUseCase.execute(
      _ChangeDefaultCarrierUseCaseObserver(this),
      ChangeDefaultCarrierUseCaseParams(
        type,
        id,
        carrierId,
        title,
      ),
    );
  }

  @override
  void dispose() {
    getInvoiceSettingUseCase.dispose();
    submitDonationCodeUseCase.dispose();
    changeDefaultCarrierUseCase.dispose();
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

class _SubmitDonationCodeUseCaseObserver
    extends Observer<SubmitDonationCodeUseCaseResponse> {
  final InvoiceSettingPresenter presenter;
  _SubmitDonationCodeUseCaseObserver(this.presenter);

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

class _SubmitMobileCarrierUseCaseObserver
    extends Observer<SubmitMobileCarrierUseCaseResponse> {
  final InvoiceSettingPresenter presenter;
  _SubmitMobileCarrierUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    presenter.submitMobileCarrierOnComplete();
  }

  @override
  void onError(e) {
    presenter.submitMobileCarrierOnError(e);
  }

  @override
  void onNext(response) {
    presenter.submitMobileCarrierOnNext(response?.result);
  }
}

class _SubmitCitizenDigitalCarrierUseCaseObserver
    extends Observer<SubmitCitizenDigitalCarrierUseCaseResponse> {
  final InvoiceSettingPresenter presenter;
  _SubmitCitizenDigitalCarrierUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    presenter.submitCitizenDigitalCarrierOnComplete();
  }

  @override
  void onError(e) {
    presenter.submitCitizenDigitalCarrierOnError(e);
  }

  @override
  void onNext(response) {
    presenter.submitCitizenDigitalCarrierOnNext(response?.result);
  }
}

class _ChangeDefaultCarrierUseCaseObserver
    extends Observer<ChangeDefaultCarrierUseCaseResponse> {
  final InvoiceSettingPresenter presenter;
  _ChangeDefaultCarrierUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    presenter.changeDefaultCarrierOnComplete();
  }

  @override
  void onError(e) {
    presenter.changeDefaultCarrierOnError(e);
  }

  @override
  void onNext(response) {
    presenter.changeDefaultCarrierOnNext(response?.result);
  }
}
