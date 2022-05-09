
import 'package:brandstores/src/domain/entities/module/module.dart';

abstract class ModulesRepository {
  Future<ModuleList> getModules();
}
