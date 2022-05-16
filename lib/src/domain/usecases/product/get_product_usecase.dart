import 'dart:async';

import '../../entities/product/product.dart';
import '../../repositories/product_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class GetProductUseCase
    extends UseCase<GetProductUseCaseResponse, GetProductUseCaseParams> {
  final ProductRepository productRepository;
  GetProductUseCase(this.productRepository);

  @override
  Future<Stream<GetProductUseCaseResponse?>> buildUseCaseStream(
      GetProductUseCaseParams? params) async {
    final controller = StreamController<GetProductUseCaseResponse>();

    if (params?.goodsNo != null) {
      try {
        // get product
        final product = await productRepository.getProduct(
            goodsNo: params!.goodsNo, productId: params.productId);
        // Adding it triggers the .onNext() in the `Observer`
        // It is usually better to wrap the reponse inside a respose object.
        controller.add(GetProductUseCaseResponse(product));
        logger.finest('GetProductUseCase successful.');
        controller.close();
      } catch (e) {
        logger.severe('GetProductUseCase unsuccessful.');
        // Trigger .onError
        controller.addError(e);
      }
    } else {
      logger.severe('GetProductUseCase unsuccessful. User id is null');
      // Trigger .onError
      controller.addError(Exception('User id is null'));
    }
    return controller.stream;
  }
}

/// Wrapping params inside an object makes it easier to change later
class GetProductUseCaseParams {
  final String goodsNo;
  final int? productId;
  GetProductUseCaseParams(this.goodsNo, this.productId);
}

/// Wrapping response inside an object makes it easier to change later
class GetProductUseCaseResponse {
  final Product product;
  GetProductUseCaseResponse(this.product);
}
