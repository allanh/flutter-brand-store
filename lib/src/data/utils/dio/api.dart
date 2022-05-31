import 'package:flutter/foundation.dart';

class Api {
  static const baseUrl =
      kDebugMode ? 'http://35.189.170.116:8000' : 'http://35.189.170.116:8000';

  static const login = '/udi/v3/auth/login';
  static const memberData = '/udi/v1/member_center/update/data';

  // Help Center
  static const faq = '/udi/v1/cms/faq';
  static const bulletin = '/udi/v1/cms/bulletin';
  static const privacy = '/udi/v1/cms/privacy';
  static const terms = '/udi/v1/cms/terms';
  static const about = '/udi/v1/cms/about';

  static const siteSetting = '/udi/v1/site/init';

  static const modules = '/udi/v1/app_layout/published/source';

// Member
  static const memberCenter = '/udi/v1/member_center';
  static const memberProfile = '/udi/v1/member_center/update/data';
  static const memberVerification = '/udi/v3/auth/send_verification';
  static const updateProfile = '/udi/v1/member_center/update/data';

  // Product
  static const getProduct = '/udi/v2/goods/info';
}
