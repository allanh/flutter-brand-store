import 'package:brandstores/src/domain/usecases/helper_center/get_bulletin_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class BulletinPresenter extends Presenter {
  late Function onNext;
  late Function onComplete;
  late Function onError;

  final GetBulletinUseCase useCase;

  BulletinPresenter(repo) : useCase = GetBulletinUseCase(repo);

  void getBulletin() {
    useCase.execute(_UseCaseObserver(this), GetBulletinUseCaseParams());
  }

  @override
  void dispose() {
    useCase.dispose();
  }
}

class _UseCaseObserver extends Observer<GetBulletinUseCaseResponse> {
  final BulletinPresenter presenter;

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
