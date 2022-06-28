import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../../domain/usecases/member/get_shipping_infos_usecase.dart';

class ShippingInfosPresenter extends Presenter {
  ShippingInfosPresenter(repo)
      : getShippingInfosUseCase = GetShippingInfosUseCase(repo);

  late Function getShippingInfosOnNext;
  late Function getShippingInfosOnComplete;
  late Function getShippingInfosOnError;

  final GetShippingInfosUseCase getShippingInfosUseCase;

  void getShippingInfos() {
    getShippingInfosUseCase.execute(
      _GetShippingInfosUseCaseObserver(this),
      GetShippingInfosUseCaseParams(),
    );
  }

  @override
  void dispose() {
    getShippingInfosUseCase.dispose();
  }
}

class _GetShippingInfosUseCaseObserver
    extends Observer<GetShippingInfosUseCaseResponse> {
  final ShippingInfosPresenter presenter;

  _GetShippingInfosUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    presenter.getShippingInfosOnComplete();
  }

  @override
  void onError(e) {
    presenter.getShippingInfosOnError(e);
  }

  @override
  void onNext(response) {
    presenter.getShippingInfosOnNext(response?.info.shippingInfos);
  }
}
