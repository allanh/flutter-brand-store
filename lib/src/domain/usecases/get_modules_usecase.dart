import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../entities/module/module.dart';
import '../repositories/modules_respository.dart';

class GetModulesUseCase
    extends UseCase<GetModulesUseCaseResponse, GetModulesUseCaseParams> {
  final ModulesRepository modulesRepository;
  GetModulesUseCase(this.modulesRepository);

  @override
  Future<Stream<GetModulesUseCaseResponse?>> buildUseCaseStream(
      GetModulesUseCaseParams? params) async {
    final controller = StreamController<GetModulesUseCaseResponse>();

    try {
      // get site setting
      final moduleList = await modulesRepository.getModules();
      // Adding it triggers the .onNext() in the `Observer`
      // It is usually better to wrap the reponse inside a respose object.
      controller.add(GetModulesUseCaseResponse(moduleList));
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
class GetModulesUseCaseParams {
  GetModulesUseCaseParams();
}

/// Wrapping response inside an object makes it easier to change later
class GetModulesUseCaseResponse {
  final ModuleList moduleList;
  GetModulesUseCaseResponse(this.moduleList);
}
