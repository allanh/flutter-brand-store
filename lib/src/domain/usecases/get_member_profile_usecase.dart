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

import 'package:brandstores/src/domain/entities/member_center/member_center.dart';
import 'package:brandstores/src/domain/repositories/member_profile_repository.dart';

class GetMemberProfileUseCase extends UseCase<GetMemberProfileUseCaseResponse,
    GetMemberProfileUseCaseParams> {
  final MemberProfileRepository memberProfileRepository;
  GetMemberProfileUseCase(this.memberProfileRepository);

  @override
  Future<Stream<GetMemberProfileUseCaseResponse?>> buildUseCaseStream(
      GetMemberProfileUseCaseParams? params) async {
    final controller = StreamController<GetMemberProfileUseCaseResponse>();

    try {
      // get member center
      final member = await memberProfileRepository.getMemberProfile();
      // Adding it triggers the .onNext() in the 'Observer'
      // It is usually better to wrap the response inside a response object.
      controller.add(GetMemberProfileUseCaseResponse(member));
      logger.finest('GetMemberProfileUseCase successful.');
      controller.close();
    } catch (e) {
      logger.severe('GetMemberProfileUseCase failure.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

/// Wrapping response inside an object makes it easier to change later
class GetMemberProfileUseCaseResponse {
  final Member member;
  GetMemberProfileUseCaseResponse(this.member);
}

/// Wrapping params inside an object makes it easier to change later
class GetMemberProfileUseCaseParams {
  GetMemberProfileUseCaseParams();
}
