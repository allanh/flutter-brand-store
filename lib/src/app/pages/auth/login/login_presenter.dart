import 'package:brandstores/src/domain/usecases/account/get_login_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class LoginPresenter extends Presenter {
  late Function onNext;
  late Function onComplete;
  late Function onError;

  final GetLoginUseCase useCase;

  LoginPresenter(repo) : useCase = GetLoginUseCase(repo);

  void doLogin(String mobileCode, String mobile, String email, String password) {
    useCase.execute(
        _UseCaseObserver(this), GetLoginUseCaseParams(mobileCode, mobile, email, password));
  }

  @override
  void dispose() {
    useCase.dispose();
  }
}

class _UseCaseObserver extends Observer<GetLoginUseCaseResponse> {
  final LoginPresenter presenter;

  _UseCaseObserver(this.presenter);

  @override
  void onComplete() {
    presenter.onComplete();
  }

  @override
  void onError(e) {
    presenter.onError(e);
  }

  @override
  void onNext(response) {
    presenter.onNext(response);
  }
}
