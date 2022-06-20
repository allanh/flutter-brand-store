import 'package:brandstores/src/domain/usecases/member/get_shipping_info_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class ShippingInfoPresenter extends Presenter {
  ShippingInfoPresenter(repo)
      : getShippingInfoUseCase = GetShippingInfoUseCase(repo);

  final GetShippingInfoUseCase getShippingInfoUseCase;

  late Function getShippingInfoOnNext;
  late Function getShippingInfoOnComplete;
  late Function getShippingInfoOnError;

  void getShippingInfo() {
    getShippingInfoUseCase.execute(
        _GetShippingInfoUseCaseObserver(this), GetShippingInfoUseCaseParams());
  }

  @override
  void dispose() {
    getShippingInfoUseCase.dispose();
  }
}

class _GetShippingInfoUseCaseObserver
    extends Observer<GetShippingInfoUseCaseResponse> {
  final ShippingInfoPresenter presenter;

  _GetShippingInfoUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    presenter.getShippingInfoOnComplete();
  }

  @override
  void onNext(response) {
    presenter.getShippingInfoOnNext(response?.info.shippingInfos);
  }

  @override
  void onError(e) {
    presenter.getShippingInfoOnError(e);
  }
}
