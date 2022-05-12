import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../domain/entities/link.dart';
import './home_presenter.dart';
import '../../../domain/entities/module/module.dart';

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
      debugPrint('User retrieved');
    };

    // On error, show a snackbar, remove the user, and refresh the UI
    homePresenter.getModulesOnError = (e) {
      debugPrint('Could not retrieve user.');
      ScaffoldMessenger.of(getContext())
          .showSnackBar(SnackBar(content: Text(e.message)));
      _moduleList = null;
      refreshUI(); // Refreshes the UI manually
    };
  }

  void getModules() => homePresenter.getModules();

  void onTap(Link link) => {debugPrint(link.value)};

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
