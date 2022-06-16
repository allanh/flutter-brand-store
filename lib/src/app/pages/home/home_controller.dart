import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/link.dart';
import './home_presenter.dart';
import '../../../domain/entities/module/module.dart';
import '../../utils/constants.dart';

class HomeController extends Controller {
  ModuleList? _moduleList;
  ModuleList? get moduleList => _moduleList; // data used by the View
  final HomePresenter homePresenter;
  // Presenter should always be initialized this way
  HomeController(modulesRepo)
      : homePresenter = HomePresenter(modulesRepo),
        super();

  @override
  void onInitState() {
    getModules();
  }

  @override
  // this is called automatically by the parent class
  void initListeners() {
    homePresenter.getModulesOnNext = (ModuleList moduleList) {
      debugPrint(moduleList.toString());
      _moduleList = moduleList;
      refreshUI(); // Refreshes the UI manually
    };
    homePresenter.getModulesOnComplete = () {
      debugPrint('Module list retrieved');
    };

    // On error, show a snackbar, remove the module list, and refresh the UI
    homePresenter.getModulesOnError = (e) {
      debugPrint('Could not mudule list');
      ScaffoldMessenger.of(getContext())
          .showSnackBar(SnackBar(content: Text(e.message)));
      _moduleList = null;
      refreshUI(); // Refreshes the UI manually
    };
  }

  void getModules() => homePresenter.getModules();

  void onTap(Link? link) {
    if (link != null) {
      switch (link.type) {
        case LinkType.product:
          getContext().pushNamed(productRouteName,
              params: {QueryKey.goodsNo: link.value});
          break;
        default:
          debugPrint('default link');
      }
    } else {
      debugPrint('no link');
    }
  }

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
    homePresenter.dispose(); // don't forget to dispose of the presenter
    super.onDisposed();
  }
}
