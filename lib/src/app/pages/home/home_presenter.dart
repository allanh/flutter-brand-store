import '../../../domain/usecases/get_modules_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class HomePresenter extends Presenter {
  late Function getModulesOnNext;
  late Function getModulesOnComplete;
  late Function getModulesOnError;

  final GetModulesUseCase getModulesUseCase;
  HomePresenter(modulesRepo) : getModulesUseCase = GetModulesUseCase(modulesRepo);

  void getModules() {
    // execute getUseruserCase
    getModulesUseCase.execute(
        _GetModulesUseCaseObserver(this), GetModulesUseCaseParams());
  }

  @override
  void dispose() {
    getModulesUseCase.dispose();
  }
}

class _GetModulesUseCaseObserver extends Observer<GetModulesUseCaseResponse> {
  final HomePresenter presenter;
  _GetModulesUseCaseObserver(this.presenter);
  @override
  void onComplete() {
    // assert(presenter.getUserOnComplete != null);
    presenter.getModulesOnComplete();
  }

  @override
  void onError(e) {
    // assert(presenter.getUserOnError != null);
    presenter.getModulesOnError(e);
  }

  @override
  void onNext(response) {
    // assert(presenter.getUserOnNext != null);
    presenter.getModulesOnNext(response?.moduleList);
  }
}
