import 'package:brandstores/src/domain/entities/helper_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'faq_presenter.dart';

class FaqController extends Controller {
  int _expandIndex = -1;

  int get expandIndex => _expandIndex;

  Faq? _faq;

  Faq? get faq => _faq; // data used by the View

  final FaqPresenter presenter;

  FaqController(repo)
      : presenter = FaqPresenter(repo),
        super();

  List<Category> getItems() {
    return _faq?.groups ?? [];
  }

  void setExpandIndex(int index, bool isExpand) {
    if (isExpand) {
      _expandIndex = -1;
    } else {
      _expandIndex = index;
    }
    refreshUI();
  }

  @override
  void onInitState() {
    presenter.getFaq();
  }

  @override
  // this is called automatically by the parent class
  void initListeners() {
    presenter.onNext = (Faq data) {
      _faq = data;
      refreshUI(); // Refreshes the UI manually
    };
    presenter.onComplete = () {};

    // On error, show a snackbar, remove the user, and refresh the UI
    presenter.onError = (e) {
      ScaffoldMessenger.of(getContext())
          .showSnackBar(SnackBar(content: Text(e.message)));
      _faq = null;
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
