import '../../domain/usecases/get_site_setting_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class MainPresenter extends Presenter {
  late Function getSiteSettingOnNext;
  late Function getSiteSettingOnComplete;
  late Function getSiteSettingOnError;

  final GetSiteSettingUseCase getSiteSettingUseCase;
  MainPresenter(siteSettingRepo) : getSiteSettingUseCase = GetSiteSettingUseCase(siteSettingRepo);

  void getSiteSetting() {
    // execute getUseruserCase
    getSiteSettingUseCase.execute(
        _GetSiteSettingUseCaseObserver(this), GetSiteSettingUseCaseParams());
  }

  @override
  void dispose() {
    getSiteSettingUseCase.dispose();
  }
}

class _GetSiteSettingUseCaseObserver extends Observer<GetSiteSettingUseCaseResponse> {
  final MainPresenter presenter;
  _GetSiteSettingUseCaseObserver(this.presenter);
  @override
  void onComplete() {
    // assert(presenter.getUserOnComplete != null);
    presenter.getSiteSettingOnComplete();
  }

  @override
  void onError(e) {
    // assert(presenter.getUserOnError != null);
    presenter.getSiteSettingOnError(e);
  }

  @override
  void onNext(response) {
    // assert(presenter.getUserOnNext != null);
    presenter.getSiteSettingOnNext(response?.siteSetting);
  }
}
