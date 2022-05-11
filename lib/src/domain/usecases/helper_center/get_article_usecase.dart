import 'dart:async';

import 'package:brandstores/src/domain/entities/helper_center.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../repositories/helper_center_repository.dart';

class GetArticleUseCase
    extends UseCase<GetArticleUseCaseResponse, GetArticleUseCaseParams> {
  final HelperCenterRepository helperCenterRepository;

  GetArticleUseCase(this.helperCenterRepository);

  @override
  Future<Stream<GetArticleUseCaseResponse?>> buildUseCaseStream(
      GetArticleUseCaseParams? params) async {
    final controller = StreamController<GetArticleUseCaseResponse>();

    var articleType = params?.articleType;
    if (articleType != null) {
      try {
        final data = await helperCenterRepository.getArticle(articleType);
        controller.add(GetArticleUseCaseResponse(data));
        controller.close();
      } catch (e) {
        controller.addError(e);
      }
    } else {
      controller.addError(Exception('article type is null'));
    }
    return controller.stream;
  }
}

class GetArticleUseCaseParams {
  final ArticleType articleType;

  GetArticleUseCaseParams(this.articleType);
}

class GetArticleUseCaseResponse {
  final Article data;

  GetArticleUseCaseResponse(this.data);
}
