/// The 'Domain' module defines the business logic of the application. It is a module
/// that is independent from the development platform i.e. it is written purely in the
/// programming lannguage and does not contain any elements from the platform. In the
/// case of 'Flutter', 'Domain' would be written purely in 'Dart' without any 'Flutter'
/// elements. The reason for that is that 'Domain' should only be concerned with the
/// business logic of the application, not with the implementation details.
/// This also allows for easy migration between platforms, should any issues arise.
/// 'Usecases'
/// - Application-specific business rules
/// - Encapsulate all the usecases of the application
/// - Orchestrate the flow of data throughtout the app
/// - Should not be affected by any UI changes whatsoever
/// - Might change if the funcationality and flow of application change

import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'package:brandstores/src/domain/entities/member/member_center.dart';
import 'package:brandstores/src/domain/repositories/member/member_center_repository.dart';

class GetMemberCenterUseCase extends UseCase<GetMemberCenterUseCaseResponse,
    GetMemberCenterUseCaseParams> {
  final MemberCenterRepository memberCenterRepository;
  GetMemberCenterUseCase(this.memberCenterRepository);

  @override
  Future<Stream<GetMemberCenterUseCaseResponse?>> buildUseCaseStream(
      GetMemberCenterUseCaseParams? params) async {
    final controller = StreamController<GetMemberCenterUseCaseResponse>();

    try {
      // get member center
      final memberCenter = await memberCenterRepository.getMemberCenter();
      // Adding it triggers the .onNext() in the 'Observer'
      // It is usually better to wrap the response inside a response object.
      controller.add(GetMemberCenterUseCaseResponse(memberCenter));
      logger.finest('GetMemberCenterUseCase successful.');
      controller.close();
    } catch (e) {
      logger.severe('GetMemberCenterUseCase failure.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

/// Wrapping response inside an object makes it easier to change later
class GetMemberCenterUseCaseResponse {
  final MemberCenter memberCenter;
  GetMemberCenterUseCaseResponse(this.memberCenter);
}

/// Wrapping params inside an object makes it easier to change later
class GetMemberCenterUseCaseParams {
  GetMemberCenterUseCaseParams();
}
