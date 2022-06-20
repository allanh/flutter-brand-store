import 'dart:async';

import 'package:brandstores/src/domain/repositories/member/member_center_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../entities/site_setting/site_setting.dart';
import '../entities/member/member_center.dart';
import '../repositories/drawer_info_respository.dart';

class GetDrawerInfoUseCase
    extends UseCase<GetDrawerInfoUseCaseResponse, GetDrawerInfoUseCaseParams> {
  final DrawerInfoRepository drawerInfoRepository;
  final MemberCenterRepository memberCenterRepository;
  GetDrawerInfoUseCase(this.drawerInfoRepository, this.memberCenterRepository);
  // GetMemberCenterUseCase(this. )

  @override
  Future<Stream<GetDrawerInfoUseCaseResponse?>> buildUseCaseStream(
      GetDrawerInfoUseCaseParams? params) async {
    final controller = StreamController<GetDrawerInfoUseCaseResponse>();

    try {
      // get site setting
      final siteSetting = await drawerInfoRepository.getDrawerInfo();
      final memberCenter = await memberCenterRepository.getMemberCenter();
      // Adding it triggers the .onNext() in the `Observer`
      // It is usually better to wrap the reponse inside a respose object.
      controller.add(GetDrawerInfoUseCaseResponse(siteSetting, memberCenter));
      logger.finest('GetSiteSettingUseCase successful.');
      controller.close();
    } catch (e) {
      logger.severe('GetSiteSettingUseCase unsuccessful.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

/// Wrapping params inside an object makes it easier to change later
class GetDrawerInfoUseCaseParams {
  GetDrawerInfoUseCaseParams();
}

/// Wrapping response inside an object makes it easier to change later
class GetDrawerInfoUseCaseResponse {
  final SiteSetting siteSetting;
  final MemberCenter memberCenter;
  GetDrawerInfoUseCaseResponse(this.siteSetting, this.memberCenter);
}
