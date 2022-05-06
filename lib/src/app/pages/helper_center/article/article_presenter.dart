import 'package:brandstores/src/domain/entities/helper_center.dart';
import 'package:brandstores/src/domain/usecases/helper_center/get_article_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class ArticlePresenter extends Presenter {
  late Function onNext;
  late Function onComplete;
  late Function onError;

  final GetArticleUseCase getArticleUseCase;

  ArticlePresenter(repo) : getArticleUseCase = GetArticleUseCase(repo);

  void getArticle(ArticleType articleType) {
    getArticleUseCase.execute(
        _GetAboutUseCaseObserver(this), GetArticleUseCaseParams(articleType));
  }

  @override
  void dispose() {
    getArticleUseCase.dispose();
  }
}

class _GetAboutUseCaseObserver extends Observer<GetArticleUseCaseResponse> {
  final ArticlePresenter presenter;

  _GetAboutUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    presenter.onComplete();
  }

  @override
  void onError(e) {
    presenter.onError(e);
  }

  @override
  void onNext(response) {
    presenter.onNext(response?.data);
  }
}
