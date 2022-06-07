import 'package:brandstores/src/domain/entities/enum/verify_method.dart';
import 'package:brandstores/src/domain/entities/enum/verify_type.dart';
import 'package:brandstores/src/domain/usecases/account/send_verification_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class ForgetPasswordPresenter extends Presenter {
  late Function onNext;
  late Function onError;

  late final SendVerificationUseCase _useCase;

  ForgetPasswordPresenter(repo) : _useCase = SendVerificationUseCase(repo);

  @override
  void dispose() {
    _useCase.dispose();
  }

  void sendEmailVerification(String email) {
    _useCase.execute(_Observer(this),
        SendVerificationParams(VerifyType.resetPassword, VerifyMethod.email, email: email));
  }

  void sendMobileVerification(String mobileCode, String mobile) {
    _useCase.execute(
        _Observer(this),
        SendVerificationParams(VerifyType.resetPassword, VerifyMethod.mobile,
            mobileCode: mobileCode, mobile: mobile));
  }
}

class _Observer extends Observer<SendVerificationResponse> {
  final ForgetPasswordPresenter presenter;

  _Observer(this.presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) => presenter.onError(e);

  @override
  void onNext(response) => presenter.onNext(response);
}
