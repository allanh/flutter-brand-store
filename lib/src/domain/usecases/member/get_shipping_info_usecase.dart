import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../entities/member/shipping_info.dart';
import '../../repositories/member/shipping_info_repository.dart';

class GetShippingInfoUseCase extends UseCase<GetShippingInfoUseCaseResponse,
    GetShippingInfoUseCaseParams> {
  final ShippingInfoRepository repo;
  GetShippingInfoUseCase(this.repo);

  @override
  Future<Stream<GetShippingInfoUseCaseResponse?>> buildUseCaseStream(
      GetShippingInfoUseCaseParams? params) async {
    final controller = StreamController<GetShippingInfoUseCaseResponse>();

    try {
      // get member invoice setting
      final response = await repo.getShippingInfo();
      // Adding it triggers the .onNext() in the 'Observer'
      // It is usually better to wrap the response inside a response object.
      controller.add(GetShippingInfoUseCaseResponse(response));
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

class GetShippingInfoUseCaseResponse {
  final ShippingInfoResponse info;
  GetShippingInfoUseCaseResponse(this.info);
}

class GetShippingInfoUseCaseParams {
  GetShippingInfoUseCaseParams();
}
