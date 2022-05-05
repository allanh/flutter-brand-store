import '../entities/site_setting/site_setting.dart';

abstract class SiteSettingRepository {
  Future<SiteSetting> getSiteSetting();
}
