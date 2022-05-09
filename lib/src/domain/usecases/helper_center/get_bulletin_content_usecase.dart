import 'dart:async';

import 'package:brandstores/src/domain/entities/helper_center.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../repositories/helper_center_repository.dart';

class GetBulletinContentUseCase
    extends UseCase<GetArticleUseCaseResponse, GetArticleUseCaseParams> {
  final HelperCenterRepository helperCenterRepository;

  GetBulletinContentUseCase(this.helperCenterRepository);

  @override
  Future<Stream<GetArticleUseCaseResponse?>> buildUseCaseStream(
      GetArticleUseCaseParams? params) async {
    final controller = StreamController<GetArticleUseCaseResponse>();

    var mainId = params?.mainId;
    if (mainId != null) {
      try {
        final data = await helperCenterRepository.getBulletinContent(mainId);
        controller.add(GetArticleUseCaseResponse(data));
        controller.close();
      } catch (e) {
        controller.addError(e);
      }
    } else {
      controller.addError(Exception('mainId is null'));
    }
    return controller.stream;
  }
}

class GetArticleUseCaseParams {
  final int mainId;

  GetArticleUseCaseParams(this.mainId);
}

class GetArticleUseCaseResponse {
  final Article data;

  GetArticleUseCaseResponse(this.data);
}
