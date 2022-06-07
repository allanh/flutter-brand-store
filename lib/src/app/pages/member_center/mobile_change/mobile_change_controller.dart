import 'package:brandstores/src/data/repositories/data_mobile_change_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class MobileChangeController extends Controller {
  MobileChangeController(DataMobileChangeRepository dataMobileChangeRepository);

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

  String handleValidationCodeSubmit(code) {
    return '';
  }
}
