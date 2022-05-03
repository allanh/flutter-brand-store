import 'package:flutter/foundation.dart';

class Api {
  static const baseUrl =
      kDebugMode ? 'http://35.189.170.116:8000' : 'http://35.189.170.116:8000';

  static const login = '/udi/v1/auth/member_login';

  // Help Center
  static const about = '/udi/v1/cms/about';
}
