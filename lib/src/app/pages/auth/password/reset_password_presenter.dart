import 'package:brandstores/src/domain/entities/enum/verify_method.dart';
import 'package:brandstores/src/domain/usecases/account/reset_password_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class ResetPasswordPresenter extends Presenter {
  late Function onNext;
  late Function onError;

  late final ResetPasswordUseCase _useCase;

  ResetPasswordPresenter(repo) : _useCase = ResetPasswordUseCase(repo);

  @override
  void dispose() {
    _useCase.dispose();
  }

  void resetEmailPassword(String email, String password) {
    _useCase.execute(
        _Observer(this), ResetPasswordParams(VerifyMethod.email, password, email: email));
  }

  void resetMobilePassword(String mobileCode, String mobile, String password) {
    _useCase.execute(_Observer(this),
        ResetPasswordParams(VerifyMethod.mobile, password, mobileCode: mobileCode, mobile: mobile));
  }

  void resetPassword(String oldPassword, String password) {
    _useCase.execute(_Observer(this),
        ResetPasswordParams(VerifyMethod.password, password, oldPassword: oldPassword));
  }
}

class _Observer extends Observer<ResetPasswordResponse> {
  final ResetPasswordPresenter presenter;

  _Observer(this.presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) => presenter.onError(e);

  @override
  void onNext(response) => presenter.onNext(response);
}
