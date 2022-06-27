import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../entities/member/shipping_info.dart';
import '../../repositories/member/shipping_info_repository.dart';

class GetShippingAddressUseCase extends UseCase<
    GetShippingAddressUseCaseResponse, GetShippingAddressUseCaseParams> {
  final ShippingAddressRepository repo;
  GetShippingAddressUseCase(this.repo);

  @override
  Future<Stream<GetShippingAddressUseCaseResponse?>> buildUseCaseStream(
      GetShippingAddressUseCaseParams? params) async {
    final controller = StreamController<GetShippingAddressUseCaseResponse>();

    try {
      // get member invoice setting
      final response = await repo.getShippingAddress();
      // Adding it triggers the .onNext() in the 'Observer'
      // It is usually better to wrap the response inside a response object.
      controller.add(GetShippingAddressUseCaseResponse(response));
      logger.finest('GetShippingInfoUseCase successful.');
      controller.close();
    } catch (e) {
      logger.severe('GetShippingInfoUseCase failure.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

class GetShippingAddressUseCaseResponse {
  final ShippingInfoResponse info;
  GetShippingAddressUseCaseResponse(this.info);
}

class GetShippingAddressUseCaseParams {
  GetShippingAddressUseCaseParams();
}
