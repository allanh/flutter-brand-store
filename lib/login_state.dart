import 'package:brandstores/src/data/utils/storage/secure_storage.dart';
import 'package:flutter/material.dart';

import 'src/data/utils/storage/my_key.dart';
import 'src/extension/string_extension.dart';

class LoginState extends ChangeNotifier {
  final _storage = SecureStorage();
  bool _loggedIn = false;

  /// Private constructor
  LoginState._create();

  /// Public factory
  static Future<LoginState> create() async {
    // Call the private constructor
    var loginState = LoginState._create();

    // Do initialization that requires async
    var loggedIn = await loginState._storage.read(MyKey.loggedInKey);
    loginState._loggedIn = loggedIn?.toBool() ?? false;

    // Return the fully initialized object
    return loginState;
  }

  bool get loggedIn => _loggedIn;
  set loggedIn(bool value) {
    _loggedIn = value;
    _storage.write(MyKey.loggedInKey, value.toString());
    notifyListeners();
  }

  // TODO(login): 檢查是否已登入
  void checkLoggedIn() async {
    var loggedIn = await _storage.read(MyKey.loggedInKey);
    _loggedIn = loggedIn?.toBool() ?? false;
  }
}
