import 'package:brandstores/src/domain/entities/member_center/member_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:go_router/go_router.dart';

import './my_plus_drawer_presenter.dart';
import '../../domain/entities/site_setting/site_setting.dart';
import '../utils/constants.dart';

class MyPlusDrawerController extends Controller {
  SiteSetting? _siteSetting;
  SiteSetting? get siteSetting => _siteSetting; // data used by the View
  MemberCenter? _memberCenter;
  MemberCenter? get memberCenter => _memberCenter;
  final MyPlusDrawerPresenter myPlusDrawerPresenter;
  MyPlusDrawerController(drawerInfoRepo, memberCenterRepo)
      : myPlusDrawerPresenter = MyPlusDrawerPresenter(drawerInfoRepo, memberCenterRepo),
        super();
  @override
  void onInitState() {
    getDrawerInfo();
  }

  @override
  void initListeners() {
    myPlusDrawerPresenter.getDrawerOnNext = (SiteSetting siteSetting, MemberCenter memberCenter) {
      debugPrint(siteSetting.toString());
      _siteSetting = siteSetting;
      _memberCenter = memberCenter;
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
  void login() {
    getContext().goNamed(loginRouteName);
  }

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
