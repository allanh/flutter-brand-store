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
import 'package:brandstores/src/data/utils/dio/base_res.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'package:brandstores/src/domain/entities/member/member_profile.dart';
import 'package:brandstores/src/domain/repositories/member/member_profile_repository.dart';

/// 取會員資料
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

/// 門號驗證
class VerifyMobileUseCase
    extends UseCase<VerifyMobileUseCaseResponse, VerifyMobileUseCaseParams> {
  final MemberProfileRepository memberProfileRepository;
  VerifyMobileUseCase(this.memberProfileRepository);

  @override
  Future<Stream<VerifyMobileUseCaseResponse?>> buildUseCaseStream(
      VerifyMobileUseCaseParams? params) async {
    final controller = StreamController<VerifyMobileUseCaseResponse>();

    try {
      // Verify mobile
      final result = await memberProfileRepository.verifyMobile(
        params!.countryCode,
        params.mobile,
      );
      // Adding it triggers the .onNext() in the 'Observer'
      // It is usually better to wrap the response inside a response object.
      controller.add(VerifyMobileUseCaseResponse(result));
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

class VerifyMobileUseCaseResponse {
  final VerificationResult result;
  VerifyMobileUseCaseResponse(this.result);
}

class VerifyMobileUseCaseParams {
  final String countryCode;
  final String mobile;
  VerifyMobileUseCaseParams(
    this.countryCode,
    this.mobile,
  );
}

/// 下載郵遞區號
class LoadDistrictsUseCase
    extends UseCase<LoadDistrictsUseCaseResponse, LoadDistrictsUseCaseParams> {
  final MemberProfileRepository memberProfileRepository;
  LoadDistrictsUseCase(this.memberProfileRepository);

  @override
  Future<Stream<LoadDistrictsUseCaseResponse>> buildUseCaseStream(
      LoadDistrictsUseCaseParams? params) async {
    final controller = StreamController<LoadDistrictsUseCaseResponse>();

    try {
      // Verify mobile
      final result = await memberProfileRepository.loadDistricts();
      // Adding it triggers the .onNext() in the 'Observer'
      // It is usually better to wrap the response inside a response object.
      controller.add(LoadDistrictsUseCaseResponse(result));
      logger.finest('LoadDistrictsUseCaseParams successful.');
      controller.close();
    } catch (e) {
      logger.severe('LoadDistrictsUseCaseParams failure.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

class LoadDistrictsUseCaseResponse {
  final List<Districts> districts;
  LoadDistrictsUseCaseResponse(this.districts);
}

class LoadDistrictsUseCaseParams {
  LoadDistrictsUseCaseParams();
}

class UpdateProfileUseCase
    extends UseCase<UpdateProfileUseCaseResponse, UpdateProfileUseCaseParams> {
  final MemberProfileRepository memberProfileRepository;
  UpdateProfileUseCase(this.memberProfileRepository);

  @override
  Future<Stream<UpdateProfileUseCaseResponse>> buildUseCaseStream(
      UpdateProfileUseCaseParams? params) async {
    final controller = StreamController<UpdateProfileUseCaseResponse>();

    try {
      // Verify mobile
      final response =
          await memberProfileRepository.updateProfile(params?.profile);
      // Adding it triggers the .onNext() in the 'Observer'
      // It is usually better to wrap the response inside a response object.
      controller.add(UpdateProfileUseCaseResponse(response));
      logger.finest('LoadDistrictsUseCaseParams successful.');
      controller.close();
    } catch (e) {
      logger.severe('LoadDistrictsUseCaseParams failure.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

class UpdateProfileUseCaseResponse {
  final BaseResponse response;
  UpdateProfileUseCaseResponse(this.response);
}

class UpdateProfileUseCaseParams {
  final MemberProfile profile;
  UpdateProfileUseCaseParams(this.profile);
}