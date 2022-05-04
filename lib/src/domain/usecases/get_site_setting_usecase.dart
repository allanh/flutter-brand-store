import 'dart:async';

import '../entities/site_setting.dart';
import '../repositories/site_setting_respository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class GetSiteSettingUseCase
    extends UseCase<GetSiteSettingUseCaseResponse, GetSiteSettingUseCaseParams> {
  final SiteSettingRepository siteSettingRepository;
  GetSiteSettingUseCase(this.siteSettingRepository);

  @override
  Future<Stream<GetSiteSettingUseCaseResponse?>> buildUseCaseStream(
      GetSiteSettingUseCaseParams? params) async {
    final controller = StreamController<GetSiteSettingUseCaseResponse>();

    try {
      // get site setting
      final siteSetting = await siteSettingRepository.getSiteSetting();
      // Adding it triggers the .onNext() in the `Observer`
      // It is usually better to wrap the reponse inside a respose object.
      controller.add(GetSiteSettingUseCaseResponse(siteSetting));
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
class GetSiteSettingUseCaseParams {
  GetSiteSettingUseCaseParams();
}

/// Wrapping response inside an object makes it easier to change later
class GetSiteSettingUseCaseResponse {
  final SiteSetting siteSetting;
  GetSiteSettingUseCaseResponse(this.siteSetting);
}
