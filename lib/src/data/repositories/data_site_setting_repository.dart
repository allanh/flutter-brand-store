import '../../domain/entities/site_setting/site_setting.dart';
import '../../domain/repositories/site_setting_respository.dart';
import '../../data/utils/dio/api.dart';
import '../../data/utils/dio/dio_utils.dart';

class DataSiteSettingRepository extends SiteSettingRepository {
  late SiteSetting siteSetting;
  // sigleton
  // static DataSiteSettingRepository _instance;
  // factory DataSiteSettingRepository() => _instance;

  @override
  Future<SiteSetting> getSiteSetting() async {
    // Here, do some heavy work lke http requests, async tasks, etc to get data

    final response = await HttpUtils.instance.get(Api.siteSetting);
    if (response.isSuccess) {
      // Map<String, dynamic> siteSettingResponseMap = response.data;
      // SiteSetting.current = SiteSetting.fromJson(response.data);
      return SiteSetting.fromJson(response.data);
    } else {
      throw Exception('Failed to load site setting');
    }
  }
}