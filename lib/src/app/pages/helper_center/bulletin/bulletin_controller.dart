import 'package:brandstores/src/domain/entities/helper_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'bulletin_presenter.dart';

class BulletinController extends Controller {
  List<Category>? _bulletin;

  List<Category>? get bulletin => _bulletin; // data used by the View

  final BulletinPresenter presenter;

  BulletinController(repo)
      : presenter = BulletinPresenter(repo),
        super();

  List<String> getTabs() {
    return _bulletin?.map((item) => item.categoryTitle).toList() ?? [];
  }

  List<Category> getItems() {
    return _bulletin ?? [];
  }

  @override
  void onInitState() {
    presenter.getBulletin();
  }

  @override
  // this is called automatically by the parent class
  void initListeners() {
    presenter.onNext = (dynamic data) {
      _bulletin = data;
      refreshUI(); // Refreshes the UI manually
    };
    presenter.onComplete = () {};

    // On error, show a snackbar, remove the user, and refresh the UI
    presenter.onError = (e) {
      ScaffoldMessenger.of(getContext())
          .showSnackBar(SnackBar(content: Text(e.message)));
      _bulletin = null;
      refreshUI(); // Refreshes the UI manually
    };
  }

  @override
  void onResumed() => debugPrint('On resumed');

  @override
  void onReassembled() => debugPrint('View is about to be reassembled');

  @override
  void onDeactivated() => debugPrint('View is about to be deactivated');

  @override
  void onDisposed() {
    presenter.dispose(); // don't forget to dispose of the presenter
    super.onDisposed();
  }
}
