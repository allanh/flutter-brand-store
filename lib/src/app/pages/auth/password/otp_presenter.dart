import 'package:brandstores/src/domain/entities/enum/verify_type.dart';
import 'package:brandstores/src/domain/usecases/account/verify_mobile_code_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class OtpPresenter extends Presenter {
  late Function onNext;
  late Function onError;
  late final VerifyMobileCodeUseCase _useCase;

  OtpPresenter(repo) : _useCase = VerifyMobileCodeUseCase(repo);

  @override
  void dispose() {
    _useCase.dispose();
  }

  void verifyMobileCode(VerifyType verifyType, String mobileCode, String mobile, String verifyCode) {
    _useCase.execute(_Observer(this),
        VerifyMobileCodeParams(verifyType, mobileCode, mobile, verifyCode));
  }
}

class _Observer extends Observer<VerifyMobileCodeResponse> {
  final OtpPresenter presenter;

  _Observer(this.presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) => presenter.onError(e);

  @override
  void onNext(response) => presenter.onNext(response);
}
