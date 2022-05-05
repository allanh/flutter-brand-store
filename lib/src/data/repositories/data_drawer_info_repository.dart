import '../../domain/repositories/drawer_info_respository.dart';
import '../../domain/entities/site_setting/site_setting.dart';

class DataDrawerInfoRepository extends DrawerInfoRepository {
  late SiteSetting siteSetting;
  // sigleton
  // static DataSiteSettingRepository _instance;
  // factory DataSiteSettingRepository() => _instance;

  @override
  Future<SiteSetting> getDrawerInfo() async {
    // Here, do some heavy work lke http requests, async tasks, etc to get data
    return Future.delayed(
      const Duration(seconds: 0),
      () => SiteSetting.current,
    );
  }
}