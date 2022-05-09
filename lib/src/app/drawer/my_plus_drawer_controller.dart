import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import './my_plus_drawer_presenter.dart';
import '../../domain/entities/site_setting/site_setting.dart';

class MyPlusDrawerController extends Controller {
  SiteSetting? _siteSetting;
  SiteSetting? get siteSetting => _siteSetting; // data used by the View
  final MyPlusDrawerPresenter myPlusDrawerPresenter;
  MyPlusDrawerController(drawerInfoRepo)
      : myPlusDrawerPresenter = MyPlusDrawerPresenter(drawerInfoRepo),
        super();
  @override
  void onInitState() {
    getDrawerInfo();
  }
  @override
  void initListeners() {
    myPlusDrawerPresenter.getDrawerOnNext = (SiteSetting siteSetting) {
      debugPrint(siteSetting.toString());
      _siteSetting = siteSetting;
      refreshUI(); // Refreshes the UI manually
    };
    myPlusDrawerPresenter.getDrawerOnComplete = () {
      debugPrint('Drawer info retrieved');
    };

    // On error, show a snackbar, remove the user, and refresh the UI
    myPlusDrawerPresenter.getDrawerOnError = (e) {
      debugPrint('Could not retrieve drawer info.');
      ScaffoldMessenger.of(getContext())
          .showSnackBar(SnackBar(content: Text(e.message)));
      _siteSetting = SiteSetting.current;
      refreshUI(); // Refreshes the UI manually
    };
  }
  void getDrawerInfo() => myPlusDrawerPresenter.getDrawerInfo();

  @override
  void onResumed() => debugPrint('On resumed');

  @override
  void onReassembled() => debugPrint('View is about to be reassembled');

  @override
  void onDeactivated() => debugPrint('View is about to be deactivated');

  @override
  void onDisposed() {
    myPlusDrawerPresenter.dispose(); // don't forget to dispose of the presenter
    super.onDisposed();
  }
}