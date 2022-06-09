import 'dart:async';
import 'package:brandstores/src/domain/entities/member_center/member_products/member_products.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:brandstores/src/domain/repositories/member_products_repository.dart';

class GetMemberHistoryProductsUseCase extends UseCase<
    GetMemberHistoryProductsUseCaseResponse,
    GetMemberHistoryProductsUseCaseParams> {
  final MemberProductsRepository memberProductsRepository;
  GetMemberHistoryProductsUseCase(this.memberProductsRepository);

  @override
  Future<Stream<GetMemberHistoryProductsUseCaseResponse?>> buildUseCaseStream(
      GetMemberHistoryProductsUseCaseParams? params) async {
    final controller =
        StreamController<GetMemberHistoryProductsUseCaseResponse>();

    try {
      // get member history products
      final memberHistoryProducts =
          await memberProductsRepository.getMemberHistoryProducts();
      // Adding it triggers the .onNext() in the 'Observer'
      // It is usually better to wrap the response inside a response object.
      controller
          .add(GetMemberHistoryProductsUseCaseResponse(memberHistoryProducts));
      logger.finest('GetMemberHistoryProductsUseCase successful.');
      controller.close();
    } catch (e) {
      logger.severe('GetMemberHistoryProductsUseCase failure.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

/// Wrapping response inside an object makes it easier to change later
class GetMemberHistoryProductsUseCaseResponse {
  final MemberProducts products;
  GetMemberHistoryProductsUseCaseResponse(this.products);
}

/// Wrapping params inside an object makes it easier to change later
class GetMemberHistoryProductsUseCaseParams {
  GetMemberHistoryProductsUseCaseParams();
}

class GetMemberFavoriteProductsUseCase extends UseCase<
    GetMemberFavoriteProductsUseCaseResponse,
    GetMemberFavoriteProductsUseCaseParams> {
  final MemberProductsRepository memberProductsRepository;
  GetMemberFavoriteProductsUseCase(this.memberProductsRepository);

  @override
  Future<Stream<GetMemberFavoriteProductsUseCaseResponse?>> buildUseCaseStream(
      GetMemberFavoriteProductsUseCaseParams? params) async {
    final controller =
        StreamController<GetMemberFavoriteProductsUseCaseResponse>();

    try {
      // get member history products
      final memberFavoriteProducts =
          await memberProductsRepository.getMemberFavoriteProducts();
      // Adding it triggers the .onNext() in the 'Observer'
      // It is usually better to wrap the response inside a response object.
      controller.add(
          GetMemberFavoriteProductsUseCaseResponse(memberFavoriteProducts));
      logger.finest('GetMemberFavoriteProductsUseCaseResponse successful.');
      controller.close();
    } catch (e) {
      logger.severe('GetMemberFavoriteProductsUseCaseResponse failure.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

/// Wrapping response inside an object makes it easier to change later
class GetMemberFavoriteProductsUseCaseResponse {
  final MemberProducts products;
  GetMemberFavoriteProductsUseCaseResponse(this.products);
}

/// Wrapping params inside an object makes it easier to change later
class GetMemberFavoriteProductsUseCaseParams {
  GetMemberFavoriteProductsUseCaseParams();
}

class GetMemberBoughtProductsUseCase extends UseCase<
    GetMemberBoughtProductsUseCaseResponse,
    GetMemberBoughtProductsUseCaseParams> {
  final MemberProductsRepository memberProductsRepository;
  GetMemberBoughtProductsUseCase(this.memberProductsRepository);

  @override
  Future<Stream<GetMemberBoughtProductsUseCaseResponse?>> buildUseCaseStream(
      GetMemberBoughtProductsUseCaseParams? params) async {
    final controller =
        StreamController<GetMemberBoughtProductsUseCaseResponse>();

    try {
      // get member history products
      final memberBoughtProducts =
          await memberProductsRepository.getMemberBoughtProducts();
      // Adding it triggers the .onNext() in the 'Observer'
      // It is usually better to wrap the response inside a response object.
      controller
          .add(GetMemberBoughtProductsUseCaseResponse(memberBoughtProducts));
      logger.finest('GetMemberBoughtProductsUseCaseResponse successful.');
      controller.close();
    } catch (e) {
      logger.severe('GetMemberBoughtProductsUseCaseResponse failure.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

/// Wrapping response inside an object makes it easier to change later
class GetMemberBoughtProductsUseCaseResponse {
  final MemberProducts products;
  GetMemberBoughtProductsUseCaseResponse(this.products);
}

/// Wrapping params inside an object makes it easier to change later
class GetMemberBoughtProductsUseCaseParams {
  GetMemberBoughtProductsUseCaseParams();
}
