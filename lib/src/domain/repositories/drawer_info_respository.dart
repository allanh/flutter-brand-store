import '../entities/site_setting/site_setting.dart';

abstract class DrawerInfoRepository {
  Future<SiteSetting> getDrawerInfo();
}
