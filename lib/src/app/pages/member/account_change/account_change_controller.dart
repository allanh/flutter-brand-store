import 'package:brandstores/src/data/repositories/member/data_account_change_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class AccountChangeController extends Controller {
  AccountChangeController(
      DataAccountChangeRepository dataAccountChangeRepository);

  @override
  void onInitState() {}

  @override
  void initListeners() {}

  @override
  void onResumed() => debugPrint('On resumed');

  @override
  void onReassembled() => debugPrint('View is about to be ressembled');

  @override
  void onDeactivated() => debugPrint('View is about to be deactivated');

  @override
  void onDisposed() {
    // don't forget to dispose of the presenter
    super.onDisposed();
  }

  bool handleCheckPassword(String password) {
    return true;
  }

  bool isValidCode(code) {
    return code.length < 5 || code.isEmpty;
  }

  bool handleAccountSubmit(text) {
    return true;
  }

  String handleValidationCodeSubmit(code) {
    return '';
  }

  bool validateEmail(String? email) {
    var regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    bool result = email == null || email.isEmpty || email.startsWith(regex);
    return result;
  }
}
