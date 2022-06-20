import 'dart:async';
import 'package:brandstores/src/domain/entities/member/member_products.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:brandstores/src/domain/repositories/member/member_products_repository.dart';

class GetMemberBrowseProductsUseCase extends UseCase<
    GetMemberBrowseProductsUseCaseResponse,
    GetMemberBrowseProductsUseCaseParams> {
  final MemberProductsRepository memberProductsRepository;
  GetMemberBrowseProductsUseCase(this.memberProductsRepository);

  @override
  Future<Stream<GetMemberBrowseProductsUseCaseResponse?>> buildUseCaseStream(
      GetMemberBrowseProductsUseCaseParams? params) async {
    final controller =
        StreamController<GetMemberBrowseProductsUseCaseResponse>();

    try {
      // get member history products
      final memberBrowseProducts =
          await memberProductsRepository.getMemberBrowseProducts(params!.page);
      // Adding it triggers the .onNext() in the 'Observer'
      // It is usually better to wrap the response inside a response object.
      controller
          .add(GetMemberBrowseProductsUseCaseResponse(memberBrowseProducts));
      logger.finest('GetMemberBrowseProductsUseCase successful.');
      controller.close();
    } catch (e) {
      logger.severe('GetMemberBrowseProductsUseCase failure.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

/// Wrapping response inside an object makes it easier to change later
class GetMemberBrowseProductsUseCaseResponse {
  final MemberProductsInfo products;
  GetMemberBrowseProductsUseCaseResponse(this.products);
}

/// Wrapping params inside an object makes it easier to change later
class GetMemberBrowseProductsUseCaseParams {
  int page;
  GetMemberBrowseProductsUseCaseParams(this.page);
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
      final memberFavoriteProducts = await memberProductsRepository
          .getMemberFavoriteProducts(params!.page);
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
  final MemberProductsInfo products;
  GetMemberFavoriteProductsUseCaseResponse(this.products);
}

/// Wrapping params inside an object makes it easier to change later
class GetMemberFavoriteProductsUseCaseParams {
  int page;
  GetMemberFavoriteProductsUseCaseParams(this.page);
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
          await memberProductsRepository.getMemberBoughtProducts(params!.page);
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
  final MemberProductsInfo products;
  GetMemberBoughtProductsUseCaseResponse(this.products);
}

/// Wrapping params inside an object makes it easier to change later
class GetMemberBoughtProductsUseCaseParams {
  int page;
  GetMemberBoughtProductsUseCaseParams(this.page);
}
