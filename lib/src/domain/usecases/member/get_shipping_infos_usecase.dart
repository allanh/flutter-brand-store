import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../entities/member/shipping_info.dart';
import '../../repositories/member/shipping_infos_repository.dart';

class GetShippingInfosUseCase extends UseCase<GetShippingInfosUseCaseResponse,
    GetShippingInfosUseCaseParams> {
  final ShippingInfosRepository repo;
  GetShippingInfosUseCase(this.repo);

  @override
  Future<Stream<GetShippingInfosUseCaseResponse?>> buildUseCaseStream(
      GetShippingInfosUseCaseParams? params) async {
    final controller = StreamController<GetShippingInfosUseCaseResponse>();

    try {
      // get member invoice setting
      final response = await repo.getShippingInfos();
      // Adding it triggers the .onNext() in the 'Observer'
      // It is usually better to wrap the response inside a response object.
      controller.add(GetShippingInfosUseCaseResponse(response));
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

class GetShippingInfosUseCaseResponse {
  final ShippingInfoResponse info;
  GetShippingInfosUseCaseResponse(this.info);
}

class GetShippingInfosUseCaseParams {
  GetShippingInfosUseCaseParams();
}
