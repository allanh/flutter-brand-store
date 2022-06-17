import 'package:flutter/foundation.dart';

class Api {
  static const baseUrl =
      kDebugMode ? 'http://35.189.170.116:8000' : 'http://35.189.170.116:8000';

  static const login = '/udi/v3/auth/login';

  // Modify Password
  static const accountCheck = '/udi/v3/auth/account_check';
  static const sendVerification = '/udi/v3/auth/send_verification';
  static const verifyMobileCode = '/udi/v3/auth/verify_mobile_code';
  static const resetPassword = '/udi/v3/auth/reset_password';

  // Register
  static const register = '/udi/v3/auth/register';
  static const exchangeBundle = '/udi/v3/auth/exchange_bundle';

  // Third Party
  static const thirdPartyLogin = '/udi/v3/auth/third_party_login';
  static const thirdPartyAccountCheck =
      '/udi/v3/auth/third_party_account_check';
  static const thirdPartyRegister = '/udi/v3/auth/third_party_register';
  static const bundleMember = '/udi/v3/auth/bundle_member';

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
  static const historyProducts = '/udi/v1/product_collections/recent_view/list';
  static const bougthProducts = '/udi/v1/member_center/order/purchase';
  static const favoriteProducts = '/udi/v1/product_collections/favorite/list';
  static const invoiceSetting = '/udi/v1/member_center/setting/invoice/list';

  // Product
  static const getProduct = '/udi/v2/goods/info';
}
