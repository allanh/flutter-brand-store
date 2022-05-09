import 'dart:async';

import 'package:brandstores/src/domain/entities/helper_center.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../repositories/helper_center_repository.dart';

class GetFaqUseCase
    extends UseCase<GetFaqUseCaseResponse, GetFaqUseCaseParams> {
  final HelperCenterRepository helperCenterRepository;

  GetFaqUseCase(this.helperCenterRepository);

  @override
  Future<Stream<GetFaqUseCaseResponse?>> buildUseCaseStream(
      GetFaqUseCaseParams? params) async {
    final controller = StreamController<GetFaqUseCaseResponse>();
    try {
      final data = await helperCenterRepository.getFaq();
      controller.add(GetFaqUseCaseResponse(data));
      controller.close();
    } catch (e) {
      controller.addError(e);
    }
    return controller.stream;
  }
}

class GetFaqUseCaseParams {
  GetFaqUseCaseParams();
}

class GetFaqUseCaseResponse {
  final Faq data;

  GetFaqUseCaseResponse(this.data);
}
