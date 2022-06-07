import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import './main_presenter.dart';
import '../../domain/entities/site_setting/site_setting.dart';

class MainController extends Controller {

  SiteSetting? _siteSetting;
  SiteSetting? get siteSetting => _siteSetting; // data used by the View
  final MainPresenter mainPresenter;
  // Presenter should always be initialized this way
  MainController(siteSettingRepo)
      : mainPresenter = MainPresenter(siteSettingRepo),
        super();

  @override
  void onInitState() {
    
    getSiteSetting();
  }
  @override
  // this is called automatically by the parent class
  void initListeners() {
    mainPresenter.getSiteSettingOnNext = (SiteSetting siteSetting) {
      debugPrint(siteSetting.toString());
      _siteSetting = siteSetting;
      refreshUI(); // Refreshes the UI manually
    };
    mainPresenter.getSiteSettingOnComplete = () {
      debugPrint('Site setting retrieved');
    };

    // On error, show a snackbar, remove the user, and refresh the UI
    mainPresenter.getSiteSettingOnError = (e) {
      debugPrint('Could not retrieve site setting.');
      ScaffoldMessenger.of(getContext())
          .showSnackBar(SnackBar(content: Text(e.message)));
      _siteSetting = SiteSetting.current;
      refreshUI(); // Refreshes the UI manually
    };
  }

  void getSiteSetting() => mainPresenter.getSiteSetting();
  void getUserwithError() => mainPresenter.getSiteSetting();

  void buttonPressed() {
    refreshUI();
  }

  @override
  void onResumed() => debugPrint('On resumed');

  @override
  void onReassembled() => debugPrint('View is about to be reassembled');

  @override
  void onDeactivated() => debugPrint('View is about to be deactivated');

  @override
  void onDisposed() {
    mainPresenter.dispose(); // don't forget to dispose of the presenter
    super.onDisposed();
  }
}
