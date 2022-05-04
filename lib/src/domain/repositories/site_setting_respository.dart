import '../entities/site_setting.dart';

abstract class SiteSettingRepository {
  Future<SiteSetting> getSiteSetting();
}
