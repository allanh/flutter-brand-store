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

import 'package:brandstores/src/domain/entities/member_profile/member_profile.dart';
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
      // get member profile
      final memberProfile = await memberProfileRepository.getMemberProfile();
      // Adding it triggers the .onNext() in the 'Observer'
      // It is usually better to wrap the response inside a response object.
      controller.add(GetMemberProfileUseCaseResponse(memberProfile));
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
  final MemberProfile memberProfile;
  GetMemberProfileUseCaseResponse(this.memberProfile);
}

/// Wrapping params inside an object makes it easier to change later
class GetMemberProfileUseCaseParams {
  GetMemberProfileUseCaseParams();
}

class GetMemberVerificationUseCase extends UseCase<
    GetMemberVerificationUseCaseResponse, GetMemberVerificationUseCaseParams> {
  final MemberVerificationRepository memberVerificationRepository;
  GetMemberVerificationUseCase(this.memberVerificationRepository);

  @override
  Future<Stream<GetMemberVerificationUseCaseResponse?>> buildUseCaseStream(
      GetMemberVerificationUseCaseParams? params) async {
    final controller = StreamController<GetMemberVerificationUseCaseResponse>();

    try {
      // get member profile
      final memberVerification =
          await memberVerificationRepository.memberVerification(
        params!.countryCode,
        params.mobile,
      );
      // Adding it triggers the .onNext() in the 'Observer'
      // It is usually better to wrap the response inside a response object.
      controller.add(GetMemberVerificationUseCaseResponse(memberVerification));
      logger.finest('GetMemberVerificationUseCase successful.');
      controller.close();
    } catch (e) {
      logger.severe('GetMemberVerificationUseCase failure.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

class GetMemberVerificationUseCaseResponse {
  final MemberVerification memberVerification;
  GetMemberVerificationUseCaseResponse(this.memberVerification);
}

class GetMemberVerificationUseCaseParams {
  final String countryCode;
  final String mobile;
  GetMemberVerificationUseCaseParams(
    this.countryCode,
    this.mobile,
  );
}
