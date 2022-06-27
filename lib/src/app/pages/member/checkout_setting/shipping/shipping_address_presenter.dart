import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../../domain/usecases/member/get_shipping_address_usecase.dart';

class ShippingAddressPresenter extends Presenter {
  ShippingAddressPresenter(repo)
      : getShippingAddressUseCase = GetShippingAddressUseCase(repo);

  late Function getShippingAddressOnNext;
  late Function getShippingAddressOnComplete;
  late Function getShippingAddressOnError;

  final GetShippingAddressUseCase getShippingAddressUseCase;

  void getShippingAddress() {
    getShippingAddressUseCase.execute(
      _GetShippingAddressUseCaseObserver(this),
      GetShippingAddressUseCaseParams(),
    );
  }

  @override
  void dispose() {
    getShippingAddressUseCase.dispose();
  }
}

class _GetShippingAddressUseCaseObserver
    extends Observer<GetShippingAddressUseCaseResponse> {
  final ShippingAddressPresenter presenter;

  _GetShippingAddressUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    presenter.getShippingAddressOnComplete();
  }

  @override
  void onError(e) {
    presenter.getShippingAddressOnError(e);
  }

  @override
  void onNext(response) {
    presenter.getShippingAddressOnNext(response?.info.shippingInfos);
  }
}
