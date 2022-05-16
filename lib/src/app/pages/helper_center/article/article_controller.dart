import 'package:brandstores/src/domain/entities/helper_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'article_presenter.dart';

class ArticleController extends Controller {
  Article? _article;

  Article? get article => _article; // data used by the View

  final ArticleType articleType;
  final ArticlePresenter presenter;

  ArticleController(repo, this.articleType)
      : presenter = ArticlePresenter(repo),
        super();

  @override
  void onInitState() {
    getArticle(articleType);
  }

  @override
  // this is called automatically by the parent class
  void initListeners() {
    presenter.onNext = (Article data) {
      debugPrint(data.toString());
      _article = data;
      refreshUI(); // Refreshes the UI manually
    };
    presenter.onComplete = () {
      debugPrint('Site setting retrieved');
    };

    // On error, show a snackbar, remove the user, and refresh the UI
    presenter.onError = (e) {
      debugPrint('Could not retrieve site setting.');
      ScaffoldMessenger.of(getContext())
          .showSnackBar(SnackBar(content: Text(e.message)));
      _article = null;
      refreshUI(); // Refreshes the UI manually
    };
  }

  void getArticle(ArticleType articleType) {
    switch (articleType) {
      case ArticleType.terms:
        presenter.getArticle(ArticleType.terms);
        break;
      case ArticleType.privacy:
        presenter.getArticle(ArticleType.privacy);
        break;
      case ArticleType.about:
        presenter.getArticle(ArticleType.about);
        break;
    }
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
