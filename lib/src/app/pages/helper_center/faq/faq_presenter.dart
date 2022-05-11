import 'package:brandstores/src/domain/usecases/helper_center/get_faq_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class FaqPresenter extends Presenter {
  late Function onNext;
  late Function onComplete;
  late Function onError;

  final GetFaqUseCase useCase;

  FaqPresenter(repo) : useCase = GetFaqUseCase(repo);

  void getFaq() {
    useCase.execute(_UseCaseObserver(this), GetFaqUseCaseParams());
  }

  @override
  void dispose() {
    useCase.dispose();
  }
}

class _UseCaseObserver extends Observer<GetFaqUseCaseResponse> {
  final FaqPresenter presenter;

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
    presenter.onNext(response?.data);
  }
}
