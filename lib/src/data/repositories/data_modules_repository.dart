
import '../../domain/entities/module/module.dart';
import '../../domain/repositories/modules_respository.dart';
import '../../data/utils/dio/api.dart';
import '../../data/utils/dio/dio_utils.dart';

class DataModulesRepository extends ModulesRepository {
  late ModuleList moduleList;
  // sigleton
  // static DataSiteSettingRepository _instance;
  // factory DataSiteSettingRepository() => _instance;

  @override
  Future<ModuleList> getModules() async {
    // Here, do some heavy work lke http requests, async tasks, etc to get data

    final response = await HttpUtils.instance.get(Api.modules);
    if (response.isSuccess) {
      // Map<String, dynamic> siteSettingResponseMap = response.data;
      // SiteSetting.current = SiteSetting.fromJson(response.data);
      return ModuleList.fromJson(response.data);
    } else {
      throw Exception('Failed to load site setting');
    }
  }
}