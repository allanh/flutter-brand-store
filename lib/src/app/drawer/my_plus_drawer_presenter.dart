
import '../../domain/usecases/get_drawer_info_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class MyPlusDrawerPresenter extends Presenter {
  late Function getDrawerOnNext;
  late Function getDrawerOnComplete;
  late Function getDrawerOnError;

  final GetDrawerInfoUseCase getDrawerInfoUseCase;
  MyPlusDrawerPresenter(drawerInfoRepo, memberCenterRepo) : getDrawerInfoUseCase = GetDrawerInfoUseCase(drawerInfoRepo, memberCenterRepo);

  void getDrawerInfo() {
    // execute getDrawerUseCase
    getDrawerInfoUseCase.execute(
        _GetDrawerInfoUseCaseObserver(this), GetDrawerInfoUseCaseParams());
  }

  @override
  void dispose() {
    getDrawerInfoUseCase.dispose();
  }
}
class _GetDrawerInfoUseCaseObserver extends Observer<GetDrawerInfoUseCaseResponse> {
  final MyPlusDrawerPresenter presenter;
  _GetDrawerInfoUseCaseObserver(this.presenter);
  @override
  void onComplete() {
    // assert(presenter.getUserOnComplete != null);
    presenter.getDrawerOnComplete();
  }

  @override
  void onError(e) {
    // assert(presenter.getUserOnError != null);
    presenter.getDrawerOnError(e);
  }

  @override
  void onNext(response) {
    // assert(presenter.getUserOnNext != null);
    presenter.getDrawerOnNext(response?.siteSetting, response?.memberCenter);
  }
}
