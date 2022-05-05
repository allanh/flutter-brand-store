import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../entities/site_setting/site_setting.dart';
import '../repositories/drawer_info_respository.dart';

class GetDrawerInfoUseCase
    extends UseCase<GetDrawerInfoUseCaseResponse, GetDrawerInfoUseCaseParams> {
  final DrawerInfoRepository drawerInfoRepository;
  GetDrawerInfoUseCase(this.drawerInfoRepository);

  @override
  Future<Stream<GetDrawerInfoUseCaseResponse?>> buildUseCaseStream(
      GetDrawerInfoUseCaseParams? params) async {
    final controller = StreamController<GetDrawerInfoUseCaseResponse>();

    try {
      // get site setting
      final siteSetting = await drawerInfoRepository.getDrawerInfo();
      // Adding it triggers the .onNext() in the `Observer`
      // It is usually better to wrap the reponse inside a respose object.
      controller.add(GetDrawerInfoUseCaseResponse(siteSetting));
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
  GetDrawerInfoUseCaseResponse(this.siteSetting);
}
