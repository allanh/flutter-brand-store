import 'dart:async';

import 'package:brandstores/src/domain/entities/helper_center.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../repositories/helper_center_repository.dart';

class GetBulletinUseCase
    extends UseCase<GetBulletinUseCaseResponse, GetBulletinUseCaseParams> {
  final HelperCenterRepository helperCenterRepository;

  GetBulletinUseCase(this.helperCenterRepository);

  @override
  Future<Stream<GetBulletinUseCaseResponse?>> buildUseCaseStream(
      GetBulletinUseCaseParams? params) async {
    final controller = StreamController<GetBulletinUseCaseResponse>();
    try {
      final data = await helperCenterRepository.getBulletin();
      controller.add(GetBulletinUseCaseResponse(data));
      controller.close();
    } catch (e) {
      controller.addError(e);
    }
    return controller.stream;
  }
}

class GetBulletinUseCaseParams {
  GetBulletinUseCaseParams();
}

class GetBulletinUseCaseResponse {
  final List<Category> data;

  GetBulletinUseCaseResponse(this.data);
}
